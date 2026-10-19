import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { after, before, beforeEach, describe, it } from "node:test";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from "@firebase/rules-unit-testing";
import {
  collection,
  collectionGroup,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
  documentId,
} from "firebase/firestore";

const rules = readFileSync(new URL("../../firestore.rules", import.meta.url), "utf8");

/** @type {import("@firebase/rules-unit-testing").RulesTestEnvironment} */
let testEnv;

function context(uid, email, verified = true) {
  return testEnv.authenticatedContext(uid, {
    email,
    email_verified: verified,
  });
}

function inboxItem(overrides = {}) {
  return {
    type: "printer",
    payloadJson: '{"name":"Prusa"}',
    senderUid: "alice",
    senderName: "Alice",
    senderEmail: "Alice@Example.com",
    createdAt: serverTimestamp(),
    ...overrides,
  };
}

describe("firestore rules", { timeout: 180000 }, () => {
  before(async () => {
    testEnv = await initializeTestEnvironment({
      projectId: "demo-gramnota-rules",
      firestore: { rules },
    });
  });

  after(async () => {
    await testEnv.cleanup();
  });

  beforeEach(async () => {
    await testEnv.clearFirestore();
  });

  it("lets the owner read and write workshop data, and denies everyone else", async () => {
    const alice = context("alice", "Alice@Example.com");
    const bob = context("bob", "bob@example.com");
    const order = {
      id: "q1",
      title: "Benchy",
      status: "quote",
      note: "rush",
      currencyCode: "SEK",
      lines: [{ title: "Benchy" }],
      filaments: [],
      extras: [],
      breakdown: { totalMinor: 100 },
      deductedGrams: {},
      createdAt: "2026-01-02T03:04:05.000Z",
      updatedAt: "2026-01-02T03:04:05.000Z",
    };
    const product = {
      id: "p1",
      name: "Benchy",
      notes: "catalog",
      createdAt: "2026-01-02T03:04:05.000Z",
      updatedAt: "2026-01-02T03:04:05.000Z",
    };

    await assertSucceeds(setDoc(doc(alice.firestore(), "users/alice/orders/q1"), order));
    await assertSucceeds(setDoc(doc(alice.firestore(), "users/alice/products/p1"), product));
    await assertSucceeds(setDoc(doc(alice.firestore(), "users/alice/settings/main"), {
      currencyCode: "SEK",
      businessName: "North",
    }));
    await assertSucceeds(getDocs(collection(alice.firestore(), "users/alice/orders")));
    await assertSucceeds(getDocs(collection(alice.firestore(), "users/alice/products")));
    await assertSucceeds(updateDoc(doc(alice.firestore(), "users/alice/orders/q1"), {
      note: "updated",
    }));

    await assertFails(getDoc(doc(bob.firestore(), "users/alice/orders/q1")));
    await assertFails(getDocs(collection(bob.firestore(), "users/alice/orders")));
    await assertFails(getDoc(doc(bob.firestore(), "users/alice/products/p1")));
    await assertFails(setDoc(doc(bob.firestore(), "users/alice/products/p2"), product));
    await assertFails(setDoc(doc(bob.firestore(), "users/alice/orders/q2"), order));
    await assertFails(deleteDoc(doc(bob.firestore(), "users/alice/orders/q1")));
    await assertFails(getDocs(collection(alice.firestore(), "users")));
    await assertFails(setDoc(doc(alice.firestore(), "users/alice/secrets/x"), { name: "nope" }));
    await assertSucceeds(deleteDoc(doc(alice.firestore(), "users/alice")));
  });

  it("caps owned documents the same way on orders and products", async () => {
    const alice = context("alice", "alice@example.com");
    const tooMany = {};
    for (let i = 0; i < 81; i += 1) {
      tooMany[`k${i}`] = 1;
    }

    await assertFails(setDoc(doc(alice.firestore(), "users/alice/orders/big"), tooMany));
    await assertFails(setDoc(doc(alice.firestore(), "users/alice/products/big"), tooMany));
    await assertFails(setDoc(doc(alice.firestore(), "users/alice/orders/note"), {
      note: "n".repeat(20001),
    }));
    await assertFails(setDoc(doc(alice.firestore(), "users/alice/products/note"), {
      notes: "n".repeat(20001),
    }));
    await assertFails(setDoc(doc(alice.firestore(), "users/alice"), { uid: "alice" }));
  });

  it("allows a single userDirectory get and denies enumeration", async () => {
    const alice = context("alice", "Alice@Example.com");
    const bob = context("bob", "bob@example.com");
    const stranger = testEnv.unauthenticatedContext();

    await assertSucceeds(setDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      uid: "alice",
      displayName: "Alice",
    }));
    await assertSucceeds(setDoc(doc(bob.firestore(), "userDirectory/bob@example.com"), {
      uid: "bob",
      displayName: "Bob",
      email: "bob@example.com",
    }));

    const found = await assertSucceeds(
      getDoc(doc(alice.firestore(), "userDirectory/bob@example.com")),
    );
    assert.equal(found.get("uid"), "bob");
    assert.equal(found.get("displayName"), "Bob");

    await assertSucceeds(getDoc(doc(alice.firestore(), "userDirectory/missing@example.com")));
    await assertFails(getDocs(collection(alice.firestore(), "userDirectory")));
    await assertFails(getDocs(query(
      collection(alice.firestore(), "userDirectory"),
      where(documentId(), "==", "bob@example.com"),
    )));
    await assertFails(getDocs(query(
      collection(bob.firestore(), "userDirectory"),
      where("uid", "==", "alice"),
    )));
    await assertFails(getDoc(doc(stranger.firestore(), "userDirectory/bob@example.com")));
    await assertFails(setDoc(doc(alice.firestore(), "userDirectory/bob@example.com"), {
      uid: "alice",
      displayName: "Alice",
    }));
    await assertFails(setDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      uid: "alice",
      displayName: "Alice",
      email: "other@example.com",
    }));
    await assertFails(setDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      uid: "alice",
      displayName: "Alice",
      phone: "070",
    }));
    await assertSucceeds(updateDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      displayName: "Alice North",
    }));
    await assertFails(updateDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      uid: "bob",
    }));

    const unverified = context("alice", "Alice@Example.com", false);
    await assertFails(setDoc(doc(unverified.firestore(), "userDirectory/alice@example.com"), {
      uid: "alice",
      displayName: "Alice",
    }));
    await assertSucceeds(getDoc(doc(unverified.firestore(), "userDirectory/bob@example.com")));
  });

  it("accepts a valid inbox create and denies invalid, oversized, and spoofed ones", async () => {
    const alice = context("alice", "Alice@Example.com");
    const bob = context("bob", "bob@example.com");
    const cara = context("cara", "cara@example.com");

    await assertSucceeds(setDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      uid: "alice",
      displayName: "Alice",
    }));

    await assertSucceeds(setDoc(
      doc(alice.firestore(), "users/bob/inbox/item-1"),
      inboxItem(),
    ));
    const legacyId = "legacy-id";
    await assertSucceeds(setDoc(
      doc(alice.firestore(), `users/bob/inbox/${legacyId}`),
      inboxItem({ id: legacyId }),
    ));

    const received = await assertSucceeds(
      getDocs(collection(bob.firestore(), "users/bob/inbox")),
    );
    assert.equal(received.size, 2);
    await assertSucceeds(deleteDoc(doc(bob.firestore(), "users/bob/inbox/item-1")));
    await assertFails(getDoc(doc(alice.firestore(), "users/bob/inbox/legacy-id")));
    await assertFails(getDoc(doc(cara.firestore(), "users/bob/inbox/legacy-id")));
    await assertFails(deleteDoc(doc(alice.firestore(), "users/bob/inbox/legacy-id")));
    await assertFails(updateDoc(doc(bob.firestore(), "users/bob/inbox/legacy-id"), {
      senderName: "changed",
    }));
    await assertFails(setDoc(doc(bob.firestore(), "users/bob/inbox/self"), inboxItem({
      senderUid: "bob",
      senderEmail: "bob@example.com",
    })));

    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/iso"), inboxItem({
      createdAt: "2026-01-02T03:04:05.000Z",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/spoof-uid"), inboxItem({
      senderUid: "cara",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/spoof-email"), inboxItem({
      senderEmail: "bob@example.com",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/extra"), inboxItem({
      role: "admin",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/bad-type"), inboxItem({
      type: "settings",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/array"), inboxItem({
      payloadJson: "[]",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/wrong-id"), inboxItem({
      id: "not-the-doc-id",
    })));
    await assertFails(setDoc(doc(alice.firestore(), "users/bob/inbox/huge"), inboxItem({
      payloadJson: `{${"a".repeat(100000)}}`,
    })));

    const unverified = context("mallory", "mallory@example.com", false);
    await testEnv.withSecurityRulesDisabled(async (admin) => {
      await setDoc(doc(admin.firestore(), "userDirectory/mallory@example.com"), {
        uid: "mallory",
        displayName: "Mallory",
      });
    });
    await assertFails(setDoc(
      doc(unverified.firestore(), "users/bob/inbox/unverified"),
      inboxItem({
        senderUid: "mallory",
        senderEmail: "mallory@example.com",
      }),
    ));

    const unlisted = context("nina", "nina@example.com");
    await assertFails(setDoc(
      doc(unlisted.firestore(), "users/bob/inbox/unlisted"),
      inboxItem({
        senderUid: "nina",
        senderName: "Nina",
        senderEmail: "nina@example.com",
      }),
    ));

    await testEnv.withSecurityRulesDisabled(async (admin) => {
      await setDoc(doc(admin.firestore(), "userDirectory/alice@example.com"), {
        uid: "someone-else",
        displayName: "Alice",
      });
    });
    await assertFails(setDoc(
      doc(alice.firestore(), "users/bob/inbox/mismatched"),
      inboxItem(),
    ));
  });

  it("runs the sharing flow: publish, lookup, send, read, decline", async () => {
    const alice = context("alice", "Alice@Example.com");
    const bob = context("bob", "Bob@Example.com");

    await assertSucceeds(setDoc(doc(alice.firestore(), "userDirectory/alice@example.com"), {
      uid: "alice",
      displayName: "Alice",
    }));
    await assertSucceeds(setDoc(doc(bob.firestore(), "userDirectory/bob@example.com"), {
      uid: "bob",
      displayName: "Bob",
    }));

    const recipient = await assertSucceeds(
      getDoc(doc(alice.firestore(), "userDirectory/bob@example.com")),
    );
    assert.equal(recipient.get("uid"), "bob");

    await assertSucceeds(setDoc(
      doc(alice.firestore(), "users/bob/inbox/share-1"),
      inboxItem({ payloadJson: '{"name":"Ada","email":"ada@example.com"}', type: "customer" }),
    ));

    const inbox = await assertSucceeds(
      getDocs(collection(bob.firestore(), "users/bob/inbox")),
    );
    assert.equal(inbox.docs[0].get("type"), "customer");
    assert.equal(inbox.docs[0].get("senderUid"), "alice");
    assert.equal(inbox.docs[0].get("senderEmail"), "Alice@Example.com");
    await assertSucceeds(deleteDoc(doc(bob.firestore(), "users/bob/inbox/share-1")));
    await assertFails(getDocs(collectionGroup(alice.firestore(), "inbox")));
    await assertFails(getDocs(collectionGroup(bob.firestore(), "orders")));
  });
});

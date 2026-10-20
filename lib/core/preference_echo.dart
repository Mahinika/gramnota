/// UTC stamp stored beside a language, theme, or currency write.
String preferenceStamp() => DateTime.now().toUtc().toIso8601String();

/// Remembers a local preference write so an older Firestore snapshot cannot
/// put the previous value back.
///
/// The snapshot that carries [expect]'s code and stamp confirms the write.
/// Until then, and after that for any stamp older than the confirmed one,
/// the local code stays. A newer stamp from another device still applies.
class PreferenceEcho {
  String? _pendingCode;
  String? _pendingAt;
  String _floorAt = '';
  String? _keptCode;

  String expect(String code, String updatedAt) {
    _pendingCode = code;
    _pendingAt = updatedAt;
    _keptCode = code;
    return code;
  }

  void release() {
    _pendingCode = null;
    _pendingAt = null;
  }

  /// The code to show for this snapshot.
  String resolve({required String remoteCode, required String updatedAt}) {
    final pending = _pendingCode;
    final at = updatedAt.trim();
    if (pending != null) {
      if (remoteCode == pending && at.isNotEmpty && at == _pendingAt) {
        _pendingCode = null;
        _pendingAt = null;
        _floorAt = at;
        _keptCode = remoteCode;
        return remoteCode;
      }
      return _keptCode ?? pending;
    }
    if (_isOlder(at, _floorAt)) {
      return _keptCode ?? remoteCode;
    }
    if (at.compareTo(_floorAt) > 0) {
      _floorAt = at;
    }
    _keptCode = remoteCode;
    return remoteCode;
  }
}

bool _isOlder(String remote, String floor) {
  if (floor.isEmpty) {
    return false;
  }
  if (remote.isEmpty) {
    return true;
  }
  return remote.compareTo(floor) < 0;
}

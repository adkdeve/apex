/// Masks an email address for display purposes
/// Examples:
/// - user@gmail.com -> us***@gmail.com
/// - ab@gmail.com -> ***ab@gmail.com
/// - a@gmail.com -> ***a@gmail.com
String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email; // Invalid email, return as-is

  final username = parts[0];
  final domain = parts[1];

  if (username.length <= 2) {
    // Show only the full short username if it's 2 chars or less
    return '***$username@$domain';
  } else {
    // Show only last 2 characters of username
    final visiblePart = username.substring(username.length - 2);
    return '***$visiblePart@$domain';
  }
}

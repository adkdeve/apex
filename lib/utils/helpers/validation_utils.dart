import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helpers/snackbar.dart';

/// Validation utility class for form validations
class Validators {
  /// Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Phone number validation
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces, dashes, and parentheses
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanedValue.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (!RegExp(r'^\+?[0-9]+$').hasMatch(cleanedValue)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Required field validation
  static String? validateRequired(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Numeric validation
  static String? validateNumeric(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final numericValue = double.tryParse(value.trim());
    if (numericValue == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  /// Positive number validation
  static String? validatePositiveNumber(
    String? value, {
    String fieldName = 'This field',
  }) {
    final numericError = validateNumeric(value, fieldName: fieldName);
    if (numericError != null) return numericError;

    final numericValue = double.parse(value!.trim());
    if (numericValue <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }

  /// Min length validation
  static String? validateMinLength(
    String? value,
    int minLength, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Max length validation
  static String? validateMaxLength(
    String? value,
    int maxLength, {
    String fieldName = 'This field',
  }) {
    if (value != null && value.trim().length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null;
  }

  /// License plate validation
  static String? validateLicensePlate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'License plate is required';
    }

    if (value.trim().length < 3) {
      return 'License plate must be at least 3 characters';
    }

    return null;
  }

  /// Vehicle name validation
  static String? validateVehicleName(String? value) {
    return validateMinLength(value, 2, fieldName: 'Vehicle name');
  }

  /// Message validation
  static String? validateMessage(String? value) {
    return validateMinLength(value, 10, fieldName: 'Message');
  }

  /// Name validation
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    }

    return null;
  }

  /// Odometer reading validation
  static String? validateOdometer(String? value) {
    final numericError = validatePositiveNumber(
      value,
      fieldName: 'Odometer reading',
    );
    if (numericError != null) return numericError;

    final numericValue = double.parse(value!.trim());
    if (numericValue > 999999) {
      return 'Odometer reading seems invalid';
    }

    return null;
  }

  /// Gallons validation
  static String? validateGallons(String? value) {
    final numericError = validatePositiveNumber(value, fieldName: 'Gallons');
    if (numericError != null) return numericError;

    final numericValue = double.parse(value!.trim());
    if (numericValue > 100) {
      return 'Gallons amount seems invalid';
    }

    return null;
  }

  /// Cost validation
  static String? validateCost(String? value) {
    return validatePositiveNumber(value, fieldName: 'Cost');
  }
}

/// Error handling utility class
class ErrorHandler {
  /// Show error snackbar
  static void showError(String message, {String title = 'Error'}) {
    SnackBarUtils.errorMsg(message);
  }

  /// Show success snackbar
  static void showSuccess(String message, {String title = 'Success'}) {
    SnackBarUtils.successMsg(message);
  }

  /// Show warning snackbar
  static void showWarning(String message, {String title = 'Warning'}) {
    SnackBarUtils.errorMsg(message);
  }

  /// Show info snackbar
  static void showInfo(String message, {String title = 'Info'}) {
    SnackBarUtils.successMsg(message);
  }

  /// Handle exceptions with user-friendly messages
  static void handleException(dynamic error, {String? customMessage}) {
    String message = customMessage ?? 'An unexpected error occurred';

    if (error is Exception) {
      message = error.toString().replaceAll('Exception: ', '');
    } else if (error is String) {
      message = error;
    }

    showError(message);
  }

  /// Validate form with error messages
  static bool validateForm(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      showError('Please fix the errors in the form');
      return false;
    }
    return true;
  }
}

/// Loading state management mixin
mixin LoadingStateMixin on GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Execute async operation with loading state and error handling
  Future<T?> executeWithLoading<T>({
    required Future<T> Function() operation,
    String? errorMessage,
    bool showSuccessMessage = false,
    String? successMessage,
  }) async {
    try {
      _isLoading.value = true;
      final result = await operation();

      if (showSuccessMessage && successMessage != null) {
        ErrorHandler.showSuccess(successMessage);
      }

      return result;
    } catch (e) {
      ErrorHandler.handleException(e, customMessage: errorMessage);
      return null;
    } finally {
      _isLoading.value = false;
    }
  }
}

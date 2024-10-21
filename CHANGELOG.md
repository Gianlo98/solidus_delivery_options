
# Changelog

## [Unreleased]

### Added
- Delivery date search functionality.
- Updated validations and admin interface.
- Localizations and custom templates.
- Added a free delivery message in the checkout UI.
- Added delivery time validation and integrated delivery options form into the checkout process.

### Changed
- Refactored the next delivery slot logic.
- Updated the admin JS to use a new format for delivery options.
- Improved handling of edge cases and error messages for delivery dates and cut-off times.
- Refined styles to support various Solidus versions and improved the date picker experience.

### Fixed
- Fixed frontend JS to properly handle delivery day selection and validation.
- Addressed various edge cases related to delivery times and overrides.
- Resolved issues with checkout validation when no delivery date is provided.

### Removed
- Removed unused spree frontend files and unnecessary validations.

## [v0.0.3]
### Added
- Delivery options form integrated into search results.
- Added delivery time and date options to the backend and order confirmation view.

### Fixed
- Various bug fixes around delivery date validation.

## [v0.0.2]
### Added
- Added configuration options for displaying delivery form on the homepage.
- Support for custom delivery times based on specific weekdays.

## [v0.0.1]
### Added
- Initial release with support for selecting delivery dates and times in the checkout process.
- Added admin interface for managing delivery options.

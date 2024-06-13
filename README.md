# Vehicles iOS App

This repository contains a iOS application for displaying vehicle results based on a JSON dataset. The app allows users to browse, filter, sort, and favorite vehicles. It is implemented using Swift (UIKit) for iOS.

## Features

- **Data Display and Filtering:**
  - Displays a list of vehicles with their logo images.
  - Filters vehicles by Make, Model, Starting Bid range, and/or shows only user's favorites.
  - Sorts vehicles by Make, Starting Bid, Mileage, and Auction Date.

- **Vehicle Details:**
  - Click on a vehicle to view detailed specifications, ownership details, and equipment.
  - Shows countdown to auction start time (days and hours).

- **Favorite Functionality:**
  - Allows users to mark vehicles as favorites and remove them from favorites.

- **Dark Mode:**
  - Supports dark mode for a better user experience in low-light environments.

- **App Logo:**
  - Includes a defined app logo for a polished appearance.

- **Testing:**
  - Includes XCTest for basic testing functionalities.

## Getting Started

To run the application locally:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/kuba7s/Vehicles_iOS.git
   cd Vehicles_iOS
   ```

2. **Open in Xcode:**
   - Open `Vehicles.xcodeproj` in Xcode.

3. **Build and Run:**
   - Select a simulator or a connected iOS device.
   - Press `Cmd + R` to build and run the application.

## Usage

- **Filtering:** Use the filter options (Make, Model, Starting Bid, Favorites) to refine the vehicle list.
- **Sorting:** Click on column headers to sort vehicles by Make, Starting Bid, Mileage, and Auction Date.
- **Favorites:** Tap on the heart icon to mark a vehicle as favorite or unfavorite it.
- **Pagination:** Navigate through pages using the pagination controls at the bottom.

## Testing

- **Unit Tests:** XCTest has been implemented for basic functionality testing.
- **Manual Testing:** Perform manual testing to ensure all features work correctly across different scenarios.
---

This README should now accurately reflect the features, setup instructions, and usage guidelines for your Vehicles iOS App repository on GitHub.

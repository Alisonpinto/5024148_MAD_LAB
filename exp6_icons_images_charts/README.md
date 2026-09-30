# Experiment 6: Icons, Images, and Charts

## Aim
To enrich the user interface using visually appealing elements like Icons, Images, and data visualization Charts using external packages.

## Theory
- **Icons**: Flutter provides the `Icon` widget to display glyphs from the Material Design icon set. They are scalable and easily colorable.
- **Images**: The `Image` widget handles displaying images. `Image.network` fetches images from the internet, while `Image.asset` loads them locally from the project's asset bundle (declared in `pubspec.yaml`).
- **Charts (`fl_chart`)**: Since Flutter lacks built-in advanced charting, we use the `fl_chart` package. It provides customizable charts like `BarChart` and `PieChart` utilizing specialized data structures (`BarChartData`, `PieChartData`).

## Steps
1. Add `fl_chart: ^0.68.0` to the `dependencies` block in `pubspec.yaml`.
2. Create an `assets/images/` directory and uncomment the `assets` block in `pubspec.yaml` to declare it.
3. Build the **Icons** section utilizing a `Row` to align four differently colored `Icon` widgets (home, favorite, settings, star).
4. Build the **Images** section with `Image.network` pointing to `picsum.photos`, and provide commented-out code for an `Image.asset` equivalent.
5. Build the **Bar Chart** section displaying 4 subjects (Math, Sci, Eng, CS) using `BarChart` and `BarChartGroupData`.
6. Build the **Pie Chart** section with 4 slices representing 40%, 30%, 20%, and 10% using `PieChartSectionData`.

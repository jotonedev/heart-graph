from data import parse_data, plot

if __name__ == "__main__":
    filename = "data/heartrate.csv"

    print("Parsing data")
    data = parse_data(filename)

    print("Plotting")
    plot(data)

    print("Complete")

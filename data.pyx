cimport numpy as np
import cython
import numpy as np
import seaborn as sns

from datetime import datetime
from matplotlib import pyplot, pylab
from pandas import read_csv, DataFrame


@cython.boundscheck(False)
@cython.wraparound(False)
cdef str float_to_datetime_str(float timestamp, int pos):
    """ Custom formatter to turn floats into e.g., 2016-05-08"""
    return datetime.fromtimestamp(timestamp).strftime('%d-%m-%Y')


@cython.boundscheck(False)
@cython.wraparound(False)
def parse_data(str filename) -> DataFrame:
    df = read_csv(filename, header=0, names=["date", "time", "heartRate"], parse_dates={"timestamp": ["date"]},
                  engine='c', on_bad_lines="skip", skiprows=[0], usecols=["date", "heartRate"], keep_date_col=True,
                  dtype={"heartRate": np.uint8, "date": str, "time": str}, infer_datetime_format=True)

    df["timestamp"] = df.timestamp.values.astype(np.int64) // 10 ** 9
    df.set_index("date")
    df.sort_values("timestamp", inplace=True)

    return df


@cython.boundscheck(False)
@cython.wraparound(False)
def plot(data: DataFrame):
    sns.set_theme(palette="muted")

    # create axis
    fig, ax = pyplot.subplots(figsize=(17.7, 10))

    # create plot
    sns.regplot(data=data, x="timestamp", y="heartRate", x_estimator=np.mean,
                line_kws={"color": (0/255, 56/255, 135/255, 0.9)}, ax=ax)

    # date formatting
    ax.xaxis.set_major_formatter(float_to_datetime_str)
    # ticks formatting
    ax.set_xticks(np.arange(min(data["timestamp"]), max(data["timestamp"]) + 6 * 10 ** 5, 6 * 10 ** 5))
    ax.set_yticks(np.arange(min(ax.get_yticks()), max(ax.get_yticks())+5, 5))
    ax.tick_params(labelrotation=45)
    # change axis label
    ax.set(xlabel='Date', ylabel='Heart Rate')

    # show plot
    # pylab.plt.show()
    # save
    pylab.plt.savefig("out/graph.png")

# heart-graph

## Description
Plot your heart rate from your exported Mi Fit data

## How to use
From Mi Fit app:
1. Go to Profile → settings → about → user rights → export data
2. Login with your account
3. Select Heart rate

On your computer:
1. Clone this repo using `git clone https://github.com/MRvillager/heart-rate`
2. Download the exported data
3. Extract it
4. Move the csv file, inside `HEARTRATE_AUTO`, to the `data` folder inside the repo
5. Rename the csv file to `heartrate.csv`
6. Compile [data.pyx](#How-to-compile-datapyx)
7. Run `python main.py`


## How to compile data.pyx
1. Install a C compiler
2. Install the dependencies using `pip install -r requirements.txt`
3. Compile the pyx file: `setup.py build_ext --inplace -DMS_WIN64`

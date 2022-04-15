import pandas as pd
from prettytable import PrettyTable

data = [["Logistic Regression","0.925769729","0.9205499018"],
        ["Decision Tree","0.905615956","0.9059533117"],
        ["Random Forests","0.946480587","0.943641364"],
        ["LSTM","0.9607136200","0.9387651"]]

df = pd.DataFrame(data, columns=["Model","AUC score", "f1 score"])

def generate_ascii_table(df):
    x = PrettyTable()
    x.field_names = df.columns.tolist()
    for row in df.values:
        x.add_row(row)
    print(x)
    return x

generate_ascii_table(df)
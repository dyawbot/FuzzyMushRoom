import csv
import os

# print(os.getcwd())


class SavingDataUsers:
    def write_csv(self, filename, data):
        with open(filename, "w", newline="") as csv_file:
            fieldnames = data[0].keys()
            writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
            writer.writeheader()
            for row in data:
                writer.writerow(row)

    def read_csv(self, filename):
        data = []
        with open(filename, "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for row in reader:
                data.append(row)
        return data

    def getData(self):
        csv_file_path = os.path.join(os.getcwd(), "Module/db/data.csv")
        data = self.read_csv(csv_file_path)
        return data


sa = SavingDataUsers()
p = sa.getData()

print(p[0]["id"])


# Modify the data
# csv_file_path = os.path.join(os.getcwd(), "Module/db/data.csv")

# data = read_csv(csv_file_path)
# data[0]["email"] = "updated@example.com"

# # Write the modified data back to the CSV file
# write_csv(csv_file_path, data)
# print(data)
# data = read_csv(os.getcwd() + "\Module\db\data.csv")
# print(data)

import argparse
from dataclasses import dataclass
from datetime import datetime
from faker import Faker
import random
import pandas as pd

parser = argparse.ArgumentParser(prog='generate.py', description='Fake Library Data Generator')
parser.add_argument('-s', '--seed', type=int, help='use the supplied seed value for random number generation')
parser.add_argument('-w', '--write', action='store_true', help='write the generated data to a CSV file')
args = parser.parse_args()
if args.seed is not None:
    Faker.seed(args.seed)
    random.seed(args.seed)

faker = Faker()
ids = pd.Series([n+1 for n in range(500)])
titles = pd.Series([faker.sentence(nb_words=5, variable_nb_words=True) for _ in range(500)])
authors = pd.Series([faker.name() for _ in range(500)])
source_genres = ['Classic Fiction', 'Literary Fiction', 'Sci-Fi/Fantasy', 'Mystery', 'Horror', 'Non-fiction', 'History', 'Biography']
genres = pd.Series([random.choice(source_genres) for _ in range(500)])
branch_ids = pd.Series([random.randint(1, 5) for _ in range(500)])
branch_names = 'Branch-' + branch_ids.astype('str')
borrower_ids = pd.Series([random.randint(1, 100) for _ in range(500)])
borrower_names = pd.Series([faker.name() for _ in range(500)])
min_start_date = datetime.strptime('2024-01-01', '%Y-%m-%d').date()
max_start_date = datetime.strptime('2024-12-31', '%Y-%m-%d').date()
borrow_dates = pd.Series([faker.date_between(min_start_date, max_start_date) for _ in range(500)])
min_end_date = datetime.strptime('2025-01-01', '%Y-%m-%d').date()
max_end_date = datetime.strptime('2025-12-31', '%Y-%m-%d').date()
return_dates = pd.Series([(None if random.random() < 0.5 else faker.date_between(min_end_date, max_end_date)) for _ in range(500)])

df = pd.DataFrame({
    'BookID': ids,
    'Title': titles,
    'Author': authors,
    'Genre': genres,
    'BranchID': branch_ids,
    'BranchName': branch_names,
    'BorrowerID': borrower_ids,
    'BorrowerName': borrower_names,
    'BorrowDate': borrow_dates,
    'ReturnDate': return_dates
})

if args.write is True:
    df.to_csv('city_library_data.csv', index=False)
print(df)
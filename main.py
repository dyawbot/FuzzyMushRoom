
# import secrets
from Module import index


def main():
    print("Main")

 

# Generate a random key of 32 bytes (256 bits)
# random_key = secrets.token_hex(32)
# print(random_key)



if __name__ == "__main__":
    app = index.Index()
    app.run()


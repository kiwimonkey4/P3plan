"""
Shopping List Component of SeaFood (Python version)

Date created: March 22nd, 2025
Authors: Matthew Chansavang & P3 Group Members
"""

# Shopping list "home page"
def shopping_home_page():
    shopping = True
    shopping_list = []
    checked_list = []
    item = ""
    
    print("Welcome to the Shopping List! Please choose an action to begin.")
    
    while (shopping == True):
        print("------------------")
        print("1. Type 'add' to add item \n2. Type 'check' to check item \nType 'remove' to remove item\n3. Type 'display' to display items in shopping list\n4.'finish' to finish shopping.")
        print("------------------")
        action = input("Action: ")
        
        if action == "add":
            item = input("What item would you like to add? ")
            add_item(shopping_list, item)
        elif action == "check":
            item = input("which item would you like to check? ")
            check_item(shopping_list, checked_list, item)
        elif action == "remove":
            item = input("which item would you like to remove? ")
            remove_item(shopping_list, item)
        elif action == "display":
            display_list(shopping_list)
        elif action == "finish":
            print("You have finished shopping!")
            shopping = False
        

def add_item(shopping_list, item : str):
    shopping_list.append(item)
    print(f"{item} has been added to the shopping list!\n")

def check_item(shopping_list, checked_list, item: str):
    shopping_list.remove(item)
    checked_list.append(item)
    print(f"{item} has been checked from the shopping list!\n")

def remove_item(shopping_list, item: str):
    shopping_list.remove(item)
    print(f"{item} has been removed from the shopping list!\n")

def display_list(shopping_list):
    print("------------------")
    print("SHOPPING LIST:")
    for item in shopping_list:
        print(item)
    print("------------------")

shopping_home_page()
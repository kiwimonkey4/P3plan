# Removes the initial part of a string
def remove_initial_str(original_str, initial_str):
    new_str = original_str.replace(initial_str, "", 1)
    return new_str

sentence = "Data: My name is Matthew"

new_sentence = remove_initial_str(sentence, "Data: ")

print(sentence)
print(new_sentence)
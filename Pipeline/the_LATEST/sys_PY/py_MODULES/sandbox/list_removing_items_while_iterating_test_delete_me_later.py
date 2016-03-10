"""
I'm testing to see if you can delete items from a list while iterating through it
technically if you were on index 4 and deleted it from that index, the next iteration, 5,
would be in the place of 6. That's my thought. Lets see if Python is smarter than that though
"""

list_h = ['0', '1', '2', '3', '4', '5', '6', '7']
for index, num in enumerate(list_h):
	print num
	list_h.remove(num)


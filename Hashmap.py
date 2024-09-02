import sys

# Initialize an empty dictionary



def Extrac_inf(filename):
    IP_dict = {}
    # Open the file in read mode ('r')
    with open(filename, 'r') as file:
        # store counter value for each ip
        for line in file:
          if line in IP_dict :
            IP_dict[line] +=1 
          else :
            IP_dict[line] = 0
       
    # make an if condtion that make two file one for source ips and one for dest ips
    if filename == "ip_dest.txt":
       for i in range(5) :
        most_frequent = max(IP_dict,key=IP_dict.get)
        # Open a file in append mode ('a') for write the most frequent ips 
        with open('top_dest_ips.txt', 'a') as file:
            file.write(f"{most_frequent}")
        del IP_dict[most_frequent]
    else :
       for i in range(5) :
        most_frequent = max(IP_dict,key=IP_dict.get)
        # Open a file in append mode ('a') for write the most frequent ips 
        with open('top_source_ips.txt', 'a') as file:
            file.write(f"{most_frequent}")
        del IP_dict[most_frequent]


# make it as poistional pramter to pass file with Python script

if __name__ == "__main__":
    # Check if the filename is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python read_file.py <filename>")
        sys.exit(1)

    # Get the filename from the command-line arguments
    filename = sys.argv[1]

    # Call the function
    Extrac_inf(filename)


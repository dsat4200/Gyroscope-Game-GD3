import bpy
import csv

def add_markers_from_csv(csv_file_path):
    # Switch to the timeline window
    bpy.context.area.ui_type = 'TIMELINE'
    
    # Read the CSV file
    with open(csv_file_path, 'r') as file:
        csv_reader = csv.reader(file)
        next(csv_reader)  # Skip the header if exists
        
        for row in csv_reader:
            timestamp = float(row[0])
            frame_number = round(timestamp * 30)  # Convert timestamp to frame number
            bpy.context.scene.frame_set(frame_number)
            print(frame_number)
            # Add marker
            bpy.context.scene.frame_current = frame_number
            bpy.ops.marker.add()
            #bpy.context.scene.timeline_markers[-1].name = f"Marker_{frame_number}"  # Rename the marker
            
    #print("Markers added successfully.")

# Example usage
csv_file_path = Variable
print(csv_file_path)
add_markers_from_csv(csv_file_path)



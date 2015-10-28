<?php
if (isset($_FILES['myFile'])) {
    // Example:
    //echo $_FILES['myFile']['tmp_name'];die();
    move_uploaded_file($_FILES['myFile']['tmp_name'], "/home/developer/photos/" . $_FILES['myFile']['name']);
    echo 'successful';
}
?>

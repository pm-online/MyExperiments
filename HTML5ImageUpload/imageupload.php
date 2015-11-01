<!--
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

AUTHOR : PANKAJ KUMAR MISHRA
PURPOSE : To upload an image using the camera device of the smartphone and upload it to the remote server
CREATED ON : Oct 27, 2015
-->

<?php
if (isset($_FILES['myFile'])) {
    // Example:
    //echo $_FILES['myFile']['tmp_name'];die();
    move_uploaded_file($_FILES['myFile']['tmp_name'], "/home/developer/photos/" . $_FILES['myFile']['name']);
    echo 'successful';
}
?>

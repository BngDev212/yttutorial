<?php
    $connection = @mysqli_connect("localhost", "root", "");
    $database = mysqli_select_db($connection, "yt_dbfinance");
?>
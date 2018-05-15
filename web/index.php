<?php
    include 'db.php';

    $db = new db;
?>
<html>
    <head>
        <title>Anatta Ice Cream</title>
    </head>
    <body>
        <h3>Containers</h3>
        <?php $db->get_containers(); ?>

        <h3>Flavors</h3>
        <?php $db->get_flavors(); ?>

        <h3>Types</h3>
        <?php $db->get_types(); ?>
    </body>
</html>

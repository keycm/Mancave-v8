<?php
include 'config.php';
header('Content-Type: application/json');

$action = $_GET['action'] ?? '';

if ($action === 'add' || $action === 'update') {
    $title = $_POST['title'];
    $artist = $_POST['artist'];
    $price = $_POST['price'];
    $status = $_POST['status'];
    $desc = $_POST['description'] ?? '';
    $id = $_POST['id'] ?? null;

    $imagePath = null;
    if (!empty($_FILES['image']['name'])) {
        $uploadDir = 'uploads/';
        if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);
        $fileName = time() . '_' . basename($_FILES['image']['name']);
        if(move_uploaded_file($_FILES['image']['tmp_name'], $uploadDir . $fileName)) {
            $imagePath = $fileName;
        }
    }

    if ($action === 'add') {
        $stmt = $conn->prepare("INSERT INTO artworks (title, artist, description, price, status, image_path) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssss", $title, $artist, $desc, $price, $status, $imagePath);
    } else {
        $sql = "UPDATE artworks SET title=?, artist=?, description=?, price=?, status=?";
        if ($imagePath) $sql .= ", image_path=?";
        $sql .= " WHERE id=?";
        $stmt = $conn->prepare($sql);
        if ($imagePath) $stmt->bind_param("ssssssi", $title, $artist, $desc, $price, $status, $imagePath, $id);
        else $stmt->bind_param("sssssi", $title, $artist, $desc, $price, $status, $id);
    }

    if ($stmt->execute()) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'message' => $conn->error]);
    exit;
}

if ($action === 'delete') {
    $id = $_POST['id'];
    // Move to trash logic (optional)
    $res = $conn->query("SELECT * FROM artworks WHERE id=$id");
    $row = $res->fetch_assoc();
    $name = $row['title'] . "|" . json_encode($row);
    
    $conn->query("INSERT INTO trash_bin (item_id, item_name, source, deleted_at) VALUES ($id, '$name', 'artworks', NOW())");
    $conn->query("DELETE FROM artworks WHERE id=$id");
    
    echo json_encode(['success' => true]);
    exit;
}
?>
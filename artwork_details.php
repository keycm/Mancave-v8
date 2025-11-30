<?php
session_start();
include 'config.php';

// Check if ID is provided
if (!isset($_GET['id'])) {
    header("Location: collection.php");
    exit();
}

$id = intval($_GET['id']);
$loggedIn = isset($_SESSION['username']);

// --- FETCH USER DATA (Profile Pic) ---
$user_profile_pic = ""; 
if ($loggedIn && isset($_SESSION['user_id'])) {
    $uid = $_SESSION['user_id'];
    $user_sql = "SELECT username, image_path FROM users WHERE id = $uid"; 
    $user_res = mysqli_query($conn, $user_sql);
    
    if ($user_data = mysqli_fetch_assoc($user_res)) {
        if (!empty($user_data['image_path'])) {
            $user_profile_pic = 'uploads/' . $user_data['image_path'];
        } else {
            $user_profile_pic = "https://ui-avatars.com/api/?name=" . urlencode($user_data['username']) . "&background=cd853f&color=fff&rounded=true&bold=true";
        }
    }
}

// --- FETCH USER FAVORITES ---
$isFav = false;
if (isset($_SESSION['user_id'])) {
    $uid = $_SESSION['user_id'];
    $fav_sql = "SELECT id FROM favorites WHERE user_id = $uid AND artwork_id = $id";
    if ($fav_res = mysqli_query($conn, $fav_sql)) {
        if (mysqli_num_rows($fav_res) > 0) {
            $isFav = true;
        }
    }
}

// 1. Fetch Current Artwork Details
$sql = "SELECT * FROM artworks WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$artwork = $result->fetch_assoc();

if (!$artwork) {
    echo "Artwork not found.";
    exit();
}

// 2. Fetch "Other Works"
$other_works = [];
$section_title = "";

$sql_artist = "SELECT * FROM artworks WHERE artist = ? AND id != ? LIMIT 4";
$stmt_artist = $conn->prepare($sql_artist);
$stmt_artist->bind_param("si", $artwork['artist'], $id);
$stmt_artist->execute();
$res_artist = $stmt_artist->get_result();

while($row = $res_artist->fetch_assoc()) {
    $other_works[] = $row;
}

if (empty($other_works)) {
    $section_title = "You Might Also Like";
    $sql_random = "SELECT * FROM artworks WHERE id != ? ORDER BY RAND() LIMIT 4";
    $stmt_random = $conn->prepare($sql_random);
    $stmt_random->bind_param("i", $id);
    $stmt_random->execute();
    $res_random = $stmt_random->get_result();
    while($row = $res_random->fetch_assoc()) {
        $other_works[] = $row;
    }
} else {
    $section_title = "Other Works By " . htmlspecialchars($artwork['artist']);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($artwork['title']); ?> | ManCave Gallery</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        /* =========================================
           GLOBAL STYLES
           ========================================= */
        :root {
            --primary: #1a1a1a;       
            --secondary: #555555;     
            --accent: #cd853f;        
            --accent-hover: #b07236;  
            --brand-red: #d63031;     
            --bg-light: #fafafa;      
            --white: #ffffff;
            --border-color: #e5e5e5;
            --radius: 4px;           
            --font-main: 'Nunito Sans', sans-serif;       
            --font-head: 'Playfair Display', serif; 
            --shadow-soft: 0 10px 40px -10px rgba(0,0,0,0.08);
            --shadow-hover: 0 20px 40px -5px rgba(0,0,0,0.15);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: var(--font-main);
            color: var(--secondary);
            background-color: #fff;
            line-height: 1.6;
            font-size: 1rem;
            overflow-x: hidden;
        }

        a { text-decoration: none; color: inherit; transition: all 0.3s ease; }
        ul { list-style: none; }

        /* =========================================
           HEADER UI
           ========================================= */
        .navbar {
            position: fixed; top: 0; width: 100%;
            background: rgba(255, 255, 255, 0.98); 
            padding: 15px 0;
            z-index: 1000; 
            border-bottom: 1px solid #eee;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .nav-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; justify-content: space-between; align-items: center; }

        .logo { text-decoration: none; display: flex; gap: 8px; align-items: baseline; white-space: nowrap; }
        .logo-top { font-family: var(--font-head); font-weight: 700; color: var(--primary); letter-spacing: 1px; font-size: 1rem; }
        .logo-main { font-family: 'Pacifico', cursive; font-size: 1.8rem; transform: rotate(-2deg); margin: 0; color: var(--primary); }
        .logo-red { color: #8B0000; } 
        .logo-bottom { font-family: var(--font-main); font-size: 0.85rem; font-weight: 800; color: var(--primary); letter-spacing: 2px; text-transform: uppercase; }

        .nav-links { display: flex; gap: 30px; }
        .nav-links a { font-weight: 700; color: var(--primary); font-size: 1rem; position: relative; transition: color 0.3s; }
        .nav-links a:hover { color: var(--accent); }

        .nav-actions { display: flex; align-items: center; gap: 15px; }
        .header-icon-btn {
            background: #f8f8f8; border: 1px solid #eee; width: 40px; height: 40px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            color: var(--primary); font-size: 1.1rem; cursor: pointer; transition: all 0.3s ease; position: relative;
        }
        .header-icon-btn:hover { background: #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1); color: var(--accent); }
        .notif-badge { position: absolute; top: -2px; right: -2px; background: var(--brand-red); color: white; font-size: 0.65rem; font-weight: bold; padding: 2px 5px; border-radius: 50%; min-width: 18px; text-align: center; border: 2px solid #fff; }

        .profile-pill { display: flex; align-items: center; gap: 10px; background: #f8f8f8; padding: 4px 15px 4px 4px; border-radius: 50px; border: 1px solid #eee; cursor: pointer; transition: all 0.3s ease; }
        .profile-pill:hover { background: #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .profile-img { width: 32px; height: 32px; border-radius: 50%; object-fit: cover; border: 2px solid var(--accent); }
        .profile-name { font-weight: 700; font-size: 0.9rem; color: var(--primary); padding-right: 5px; }

        /* Dropdowns */
        .user-dropdown, .notification-wrapper { position: relative; }
        .dropdown-content, .notif-dropdown { display: none; position: absolute; top: 140%; right: 0; background: #fff; box-shadow: 0 5px 15px rgba(0,0,0,0.1); border-radius: 8px; z-index: 1001; }
        .dropdown-content { min-width: 180px; padding: 10px 0; }
        .notif-dropdown { width: 320px; right: -10px; top: 160%; }
        .user-dropdown.active .dropdown-content, .notif-dropdown.active { display: block; animation: fadeIn 0.2s ease-out; }
        .dropdown-content a { display: block; padding: 10px 20px; color: var(--primary); font-size: 0.9rem; }
        .dropdown-content a:hover { background: #f9f9f9; color: var(--accent); }
        .notif-header { padding: 15px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; font-weight: 700; background: #fafafa; font-size: 0.9rem; }
        .notif-list { max-height: 300px; overflow-y: auto; list-style: none; padding: 0; margin: 0; }
        .notif-item { padding: 15px 35px 15px 20px; border-bottom: 1px solid #f9f9f9; font-size: 0.9rem; cursor: pointer; position: relative; }
        .notif-item:hover { background: #fdfbf7; }
        .btn-notif-close { position: absolute; top: 10px; right: 10px; background: none; border: none; color: #aaa; font-size: 1.2rem; line-height: 1; cursor: pointer; padding: 0; transition: color 0.2s; }
        .btn-notif-close:hover { color: #ff4d4d; }
        .no-notif { padding: 20px; text-align: center; color: #999; font-style: italic; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-5px); } to { opacity: 1; transform: translateY(0); } }
        .mobile-menu-icon { display: none; font-size: 1.8rem; cursor: pointer; color: var(--primary); }


        /* =========================================
           ARTWORK DETAILS LAYOUT
           ========================================= */
        .details-page-wrapper { 
            padding-top: 130px; 
            padding-bottom: 80px; 
            max-width: 1300px;
            margin: 0 auto;
            padding-left: 30px;
            padding-right: 30px;
        }

        .back-link {
            display: inline-flex; align-items: center; gap: 8px;
            margin-bottom: 40px; font-weight: 700; color: #999; 
            font-size: 0.8rem; letter-spacing: 1px;
            text-transform: uppercase;
            transition: 0.3s;
        }
        .back-link:hover { color: var(--primary); padding-left: 5px; }

        .product-grid { 
            display: grid; 
            grid-template-columns: 1.2fr 0.8fr; /* Image wider than details */
            gap: 60px; 
            align-items: start; 
            position: relative;
        }

        /* --- Left Column: Gallery Display --- */
        .gallery-side { 
            position: relative; 
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .main-image-frame {
            background-color: #fff; 
            border-radius: 2px;
            box-shadow: var(--shadow-soft);
            width: 100%; 
            height: auto; 
            min-height: 500px;
            display: flex; align-items: center; justify-content: center;
            cursor: zoom-in;
            padding: 20px;
            border: 1px solid #f0f0f0;
            overflow: hidden;
            position: relative;
        }
        
        .main-image-frame img { 
            max-width: 100%; max-height: 700px; object-fit: contain; 
            display: block; transition: transform 0.2s ease-out; 
        }

        .thumbnail-strip { 
            display: flex; gap: 15px; 
            justify-content: center; 
            padding-top: 10px;
        }
        
        .thumb-item {
            width: 70px; height: 70px; 
            border-radius: 4px; overflow: hidden;
            cursor: pointer; border: 1px solid #eee; 
            opacity: 0.6; transition: 0.3s;
            background: #fff;
        }
        .thumb-item img { width: 100%; height: 100%; object-fit: cover; }
        .thumb-item:hover, .thumb-item.active { opacity: 1; border-color: var(--primary); transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }

        /* --- Right Column: Sticky Info --- */
        .info-side { 
            position: sticky;
            top: 110px; /* Sticks below navbar */
            padding: 30px;
            background: #fff;
            border: 1px solid #f0f0f0;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
        }

        .status-badge-lg {
            display: inline-block; padding: 6px 14px; border-radius: 4px;
            font-size: 0.7rem; font-weight: 800; text-transform: uppercase;
            color: white; margin-bottom: 20px; letter-spacing: 1px;
        }
        .status-available { background: var(--primary); }
        .status-reserved { background: #f39c12; }
        .status-sold { background: #c0392b; }

        .art-header-row { 
            display: flex; justify-content: space-between; 
            align-items: flex-start; gap: 20px; margin-bottom: 10px;
        }
        
        .art-title-lg { 
            font-family: var(--font-head); 
            font-size: 2.8rem; 
            color: var(--primary); 
            margin: 0; 
            line-height: 1.1; 
            font-weight: 500;
        }
        
        .btn-heart-lg {
            width: 50px; height: 50px; 
            border-radius: 50%; border: 1px solid #eee;
            background: #fff; color: #ccc; 
            font-size: 1.3rem; cursor: pointer;
            display: flex; align-items: center; justify-content: center; 
            transition: all 0.3s ease; flex-shrink: 0;
            margin-top: 5px;
        }
        .btn-heart-lg:hover { border-color: var(--brand-red); color: var(--brand-red); transform: scale(1.05); }
        .btn-heart-lg.active { background: var(--brand-red); border-color: var(--brand-red); color: white; box-shadow: 0 5px 15px rgba(214, 48, 49, 0.3); }
        @keyframes heartPump { 0% { transform: scale(1); } 50% { transform: scale(1.3); } 100% { transform: scale(1); } }
        .btn-heart-lg.animating i { animation: heartPump 0.4s ease; }

        .art-artist-lg { 
            font-size: 1.1rem; color: #777; margin-bottom: 30px; display: block; 
            font-family: var(--font-head); font-style: italic;
        }
        .art-artist-lg span { font-weight: 600; color: var(--primary); font-style: normal; }
        .art-artist-lg a { border-bottom: 1px dotted #ccc; padding-bottom: 1px; }
        .art-artist-lg a:hover { color: var(--accent); border-bottom-color: var(--accent); }

        .price-wrapper {
            display: flex; align-items: baseline; gap: 15px; margin-bottom: 30px;
            padding-bottom: 25px; border-bottom: 1px solid #eee;
        }
        .art-price-lg { font-family: var(--font-main); font-size: 2rem; font-weight: 300; color: var(--primary); }
        .price-label { text-transform: uppercase; font-size: 0.8rem; color: #999; font-weight: 700; letter-spacing: 1px; }

        .desc-section { margin-bottom: 40px; }
        .desc-label { font-weight: 700; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 1.5px; color: var(--accent); display: block; margin-bottom: 12px; }
        .desc-text { font-size: 1rem; line-height: 1.7; color: #555; font-weight: 300; }

        .action-area { display: flex; flex-direction: column; gap: 15px; }

        .btn-reserve-block {
            width: 100%; padding: 18px; 
            background: var(--primary); color: white;
            border: 1px solid var(--primary); border-radius: 4px; 
            font-weight: 700; font-size: 0.9rem;
            text-transform: uppercase; letter-spacing: 2px; 
            cursor: pointer; transition: 0.3s;
            display: flex; justify-content: center; align-items: center; gap: 15px;
        }
        .btn-reserve-block:hover { background: #333; transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        
        .btn-reserve-block.outline {
            background: transparent; color: var(--primary); border: 1px solid #ddd;
        }
        .btn-reserve-block.outline:hover {
            border-color: var(--primary); background: #fff;
        }

        /* --- OTHER WORKS GRID (MODERN) --- */
        .other-section { padding: 80px 0; background: #fafafa; border-top: 1px solid #eee; }
        .section-head { margin-bottom: 40px; text-align: center; position: relative; }
        .section-head h2 { font-size: 2rem; margin: 0; font-family: var(--font-head); color: var(--primary); }
        .section-head::after { content: ''; display: block; width: 60px; height: 3px; background: var(--accent); margin: 15px auto 0; }
        .btn-view-all { display: block; margin-top: 10px; font-size: 0.85rem; color: #888; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; }
        .btn-view-all:hover { color: var(--accent); }

        .latest-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); 
            gap: 40px; 
        }

        .art-card-new { 
            background: transparent; 
            transition: all 0.4s ease; 
            display: flex;
            flex-direction: column;
            group: hover;
        }
        
        .art-img-wrapper-new { 
            position: relative; 
            width: 100%; 
            aspect-ratio: 4/5; 
            overflow: hidden; 
            background: #fff; 
            margin-bottom: 20px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: 0.4s;
        }
        .art-img-wrapper-new img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
            transition: transform 0.6s ease;
        }
        
        /* Hover Effects */
        .art-card-new:hover .art-img-wrapper-new { transform: translateY(-5px); box-shadow: var(--shadow-hover); }
        .art-card-new:hover img { transform: scale(1.05); }

        .badge-new { position: absolute; top: 15px; left: 15px; padding: 5px 12px; background: rgba(255,255,255,0.9); border-radius: 2px; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; color: var(--primary); z-index: 2; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        
        .art-content-new { text-align: center; }
        .art-title-new { font-size: 1.1rem; font-family: var(--font-head); color: var(--primary); margin-bottom: 5px; }
        .price-new { font-weight: 400; color: #888; font-size: 0.95rem; font-family: var(--font-main); }
        
        /* Modals */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(4px); display: flex; align-items: center; justify-content: center; opacity: 0; visibility: hidden; transition: 0.3s; z-index: 2000; }
        .modal-overlay.active { opacity: 1; visibility: visible; }
        
        /* UPDATED MODAL STYLES TO MATCH INDEX.PHP */
        .modal-card { 
            background: var(--white); 
            padding: 35px; /* Slightly more padding */
            border-radius: 12px; /* Smoother corners */
            width: 550px; /* Slightly wider */
            max-width: 95%; 
            position: relative; 
            box-shadow: 0 20px 60px rgba(0,0,0,0.2); 
            transform: translateY(20px); 
            transition: 0.3s; 
            max-height: 90vh; /* Prevent overflow */
            overflow-y: auto;
        }
        .modal-overlay.active .modal-card { transform: translateY(0); }
        
        .modal-card::-webkit-scrollbar { width: 6px; }
        .modal-card::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }
        .modal-card::-webkit-scrollbar-track { background: #f9f9f9; }

        .modal-close { position: absolute; top: 20px; right: 20px; background: none; border: none; font-size: 1.8rem; cursor: pointer; color: #999; transition: 0.3s; line-height: 1; }
        .modal-close:hover { color: var(--brand-red); }
        
        .btn-full { width: 100%; background: var(--primary); color: var(--white); padding: 16px; border-radius: 4px; border: none; font-weight: 700; cursor: pointer; font-size: 1rem; text-transform: uppercase; letter-spacing: 1px; transition: 0.3s; margin-top: 10px; }
        .btn-full:hover { background: #333; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 700; font-size: 0.85rem; color: #444; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-group input, .form-group textarea { width: 100%; padding: 14px; border: 1px solid #ddd; border-radius: 4px; font-size: 0.95rem; background: #fafafa; transition: 0.3s; }
        .form-group input:focus, .form-group textarea:focus { background: #fff; border-color: var(--primary); outline: none; }

        @media (max-width: 900px) {
            .product-grid { grid-template-columns: 1fr; gap: 40px; }
            .info-side { position: static; box-shadow: none; border: none; padding: 0; }
            .art-title-lg { font-size: 2.2rem; }
        }
        @media (max-width: 768px) {
            .navbar { background: var(--white); padding: 15px 0; border-bottom: 1px solid var(--border-color); }
            .nav-links { display: none; } 
            .mobile-menu-icon { display: block; color: var(--primary); font-size: 1.8rem; }
            .details-page-wrapper { padding-top: 100px; padding-left: 20px; padding-right: 20px; }
        }
    </style>
</head>
<body>

    <nav class="navbar scrolled">
        <div class="container nav-container">
            <a href="index.php" class="logo">
                <span class="logo-top">THE</span>
                <span class="logo-main">
                    <span class="logo-red">M</span><span class="logo-text">an</span><span class="logo-red">C</span><span class="logo-text">ave</span>
                </span>
                <span class="logo-bottom">GALLERY</span>
            </a>
            <ul class="nav-links">
                <li><a href="index.php">Home</a></li>
                <li><a href="collection.php">Collection</a></li>
                <li><a href="index.php#artists">Artists</a></li>
                <li><a href="index.php#services">Services</a></li>
                <li><a href="index.php#contact-form">Visit</a></li>
            </ul>
            <div class="nav-actions">
                <?php if ($loggedIn): ?>
                    <a href="favorites.php" class="header-icon-btn" title="My Favorites"><i class="far fa-heart"></i></a>
                    
                    <div class="notification-wrapper">
                        <button class="header-icon-btn" id="notifBtn">
                            <i class="far fa-bell"></i>
                            <span class="notif-badge" id="notifBadge" style="display:none;">0</span>
                        </button>
                        <div class="notif-dropdown" id="notifDropdown">
                            <div class="notif-header">
                                <span>Notifications</span>
                                <button id="markAllRead" style="border:none; background:none; color:var(--accent); cursor:pointer; font-size:0.8rem; font-weight:700;">Mark all read</button>
                            </div>
                            <ul class="notif-list" id="notifList">
                                <li class="no-notif">Loading...</li>
                            </ul>
                        </div>
                    </div>

                    <div class="user-dropdown">
                        <div class="profile-pill">
                            <img src="<?php echo htmlspecialchars($user_profile_pic); ?>" alt="Profile" class="profile-img">
                            <span class="profile-name"><?php echo htmlspecialchars($_SESSION['username']); ?></span>
                            <i class="fas fa-chevron-down" style="font-size: 0.7rem; color: var(--secondary);"></i>
                        </div>
                        <div class="dropdown-content">
                            <?php if(isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                                <a href="admin.php"><i class="fas fa-cog"></i> Dashboard</a>
                            <?php endif; ?>
                            <a href="profile.php"><i class="fas fa-user-cog"></i> Profile Settings</a>
                            <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </div>
                <?php else: ?>
                    <a href="index.php?login=1" class="btn-nav">Sign In</a>
                <?php endif; ?>
            </div>
            <div class="mobile-menu-icon"><i class="fas fa-bars"></i></div>
        </div>
    </nav>

    <div class="details-page-wrapper">
        <a href="collection.php" class="back-link">
            <i class="fas fa-long-arrow-alt-left"></i> Back to Collection
        </a>

        <div class="product-grid">
            <div class="gallery-side">
                <?php $imgSrc = !empty($artwork['image_path']) ? 'uploads/'.$artwork['image_path'] : 'img-21.jpg'; ?>
                
                <div class="main-image-frame" id="zoomFrame">
                    <img src="<?php echo htmlspecialchars($imgSrc); ?>" id="mainImage" alt="<?php echo htmlspecialchars($artwork['title']); ?>">
                </div>

                <div class="thumbnail-strip">
                    <div class="thumb-item active" onclick="switchImage('<?php echo $imgSrc; ?>', this)"><img src="<?php echo $imgSrc; ?>"></div>
                    <div class="thumb-item" onclick="switchImage('<?php echo $imgSrc; ?>', this)"><img src="<?php echo $imgSrc; ?>" style="filter: brightness(0.8);"></div>
                    <div class="thumb-item" onclick="switchImage('<?php echo $imgSrc; ?>', this)"><img src="<?php echo $imgSrc; ?>" style="filter: sepia(0.3);"></div>
                </div>
            </div>

            <div class="info-side">
                <?php 
                    $statusClass = strtolower($artwork['status']); 
                    $isAvailable = ($artwork['status'] === 'Available');
                ?>
                <div class="art-header-row">
                    <span class="status-badge-lg status-<?php echo $statusClass; ?>"><?php echo $artwork['status']; ?></span>
                    
                    <button class="btn-heart-lg <?php echo $isFav ? 'active' : ''; ?>" 
                            onclick="toggleFavorite(this, <?php echo $artwork['id']; ?>)" 
                            title="Toggle Favorite">
                        <i class="<?php echo $isFav ? 'fas' : 'far'; ?> fa-heart"></i>
                    </button>
                </div>

                <h1 class="art-title-lg"><?php echo htmlspecialchars($artwork['title']); ?></h1>
                
                <div class="art-artist-lg">
                    by <a href="artist_profile.php?artist=<?php echo urlencode($artwork['artist']); ?>">
                        <span><?php echo htmlspecialchars($artwork['artist']); ?></span>
                    </a>
                </div>

                <div class="price-wrapper">
                    <span class="price-label">Price</span>
                    <div class="art-price-lg">Php <?php echo number_format($artwork['price']); ?></div>
                </div>

                <div class="desc-section">
                    <span class="desc-label">About the Artwork</span>
                    <p class="desc-text">
                        <?php echo !empty($artwork['description']) ? nl2br(htmlspecialchars($artwork['description'])) : 'This original piece captures a unique moment in time, blending modern technique with classical emotion. Perfect for collectors seeking depth and character.'; ?>
                    </p>
                </div>

                <div class="action-area">
                    <?php if($isAvailable): ?>
                        <button class="btn-reserve-block" onclick="openReserveModal(<?php echo $artwork['id']; ?>, '<?php echo addslashes($artwork['title']); ?>')">
                            Reserve Artwork
                        </button>
                    <?php else: ?>
                        <button class="btn-reserve-block outline" onclick="openCopyModal('<?php echo addslashes($artwork['title']); ?>')">
                            Request Commission
                        </button>
                    <?php endif; ?>
                    
                    <div style="font-size:0.8rem; color:#999; text-align:center; margin-top:5px;">
                        <i class="fas fa-shield-alt"></i> Authenticity Guaranteed
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php if(!empty($other_works)): ?>
    <section class="other-section">
        <div class="container" style="max-width:1300px; margin:0 auto; padding:0 30px;">
            <div class="section-head">
                <h2><?php echo $section_title; ?></h2>
                <a href="collection.php" class="btn-view-all">Explore Collection</a>
            </div>
            
            <div class="latest-grid">
                <?php foreach($other_works as $work): 
                     $wImg = !empty($work['image_path']) ? 'uploads/'.$work['image_path'] : 'img-21.jpg';
                     $wStatus = strtolower($work['status']);
                ?>
                <div class="art-card-new" data-aos="fade-up">
                    <a href="artwork_details.php?id=<?php echo $work['id']; ?>" class="art-link-wrapper" style="color:inherit; text-decoration:none;">
                        <div class="art-img-wrapper-new">
                            <span class="badge-new"><?php echo $work['status']; ?></span>
                            <img src="<?php echo $wImg; ?>">
                        </div>
                        <div class="art-content-new">
                            <div class="art-title-new"><?php echo htmlspecialchars($work['title']); ?></div>
                            <span class="price-new">Php <?php echo number_format($work['price']); ?></span>
                        </div>
                    </a>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <div class="modal-overlay" id="reserveModal">
        <div class="modal-card">
            <button class="modal-close" onclick="closeModal()">&times;</button>
            <h3 style="margin-bottom:5px; font-family:var(--font-head); font-size:1.8rem;">Secure Reservation</h3>
            <p style="color:#666; margin-bottom:20px; font-size:0.9rem;">Complete your details to secure this piece.</p>
            
            <form action="submit_booking.php" method="POST">
                <input type="hidden" id="res_art_id" name="artwork_id">
                
                <div class="form-group">
                    <label>Selected Artwork</label>
                    <input type="text" id="res_art_title" name="service" readonly style="background:#f9f9f9; color:#555; border-color:#eee;">
                </div>

                <div class="form-group">
                    <label>Preferred Viewing Date</label>
                    <input type="date" name="preferred_date" required min="<?php echo date('Y-m-d'); ?>">
                </div>

                <div style="background:#fdfdfd; border:1px solid #eee; padding:15px; border-radius:8px; margin-bottom:20px;">
                    <h4 style="font-size:0.9rem; color:var(--primary); margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:5px;">Security Verification</h4>
                    <div class="form-group">
                        <label>Full Legal Name</label>
                        <input type="text" name="full_name" required placeholder="e.g. Juan dela Cruz">
                    </div>
                    <div class="form-group">
                        <label>Contact Number</label>
                        <input type="tel" name="phone_number" required placeholder="0912 345 6789" pattern="[0-9]{11}">
                    </div>
                    <p style="font-size:0.75rem; color:#888; margin-top:10px;">
                        <i class="fas fa-shield-alt"></i> Identity verification will be required upon viewing.
                    </p>
                </div>

                <div class="form-group">
                    <label>Special Requests</label>
                    <textarea name="special_requests" rows="2" placeholder="Any specific requirements?"></textarea>
                </div>

                <?php if($loggedIn): ?>
                    <button type="submit" name="submit_reservation" class="btn-full">Confirm Reservation</button>
                <?php else: ?>
                    <a href="index.php?login=1" class="btn-full" style="display:block; text-align:center; text-decoration:none;">Log In to Reserve</a>
                <?php endif; ?>
            </form>
        </div>
    </div>

    <div class="modal-overlay" id="copyModal">
        <div class="modal-card">
            <button class="modal-close" onclick="closeModal()">&times;</button>
            <h3 style="margin-bottom:5px; font-family:var(--font-head); font-size:1.8rem;">Request a Copy</h3>
            <p style="color:#666; margin-bottom:20px; font-size:0.9rem;">This piece is unavailable, but you can request a commissioned copy from the artist.</p>
            <form action="inquire.php" method="POST">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" required placeholder="Your email">
                </div>
                <div class="form-group">
                    <label>Mobile Number</label>
                    <input type="text" name="mobile" required placeholder="09..." maxlength="11">
                </div>
                <div class="form-group">
                    <label>Message</label>
                    <textarea name="message" id="copyMessage" rows="5" required></textarea>
                </div>
                <button type="submit" class="btn-full">Send Request</button>
            </form>
        </div>
    </div>

    <script>const isLoggedIn = <?php echo $loggedIn ? 'true' : 'false'; ?>;</script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800 });

        // 1. Zoom Logic
        const zoomFrame = document.getElementById('zoomFrame');
        const mainImage = document.getElementById('mainImage');
        zoomFrame.addEventListener('mousemove', function(e) {
            const { left, top, width, height } = zoomFrame.getBoundingClientRect();
            const x = (e.clientX - left) / width * 100;
            const y = (e.clientY - top) / height * 100;
            mainImage.style.transformOrigin = `${x}% ${y}%`;
            mainImage.style.transform = "scale(2)";
        });
        zoomFrame.addEventListener('mouseleave', function() { 
            mainImage.style.transform = "scale(1)"; 
            setTimeout(() => { mainImage.style.transformOrigin = 'center center'; }, 100);
        });

        // 2. Switch Image
        function switchImage(src, element) {
            document.getElementById('mainImage').src = src;
            document.querySelectorAll('.thumb-item').forEach(el => el.classList.remove('active'));
            element.classList.add('active');
        }

        // 3. Heart Logic
        function toggleFavorite(btn, id) {
            if (!isLoggedIn) { window.location.href = 'index.php?login=1'; return; }
            
            const icon = btn.querySelector('i');
            const isLiked = btn.classList.contains('active');
            const action = isLiked ? 'remove_id' : 'add_id';

            btn.classList.add('animating');
            btn.classList.toggle('active');
            
            if (isLiked) { icon.classList.remove('fas'); icon.classList.add('far'); }
            else { icon.classList.remove('far'); icon.classList.add('fas'); }

            const formData = new FormData();
            formData.append(action, id);
            fetch('favorites.php', { method: 'POST', body: formData });

            setTimeout(() => btn.classList.remove('animating'), 400);
        }

        // 4. Modal Logic
        const reserveModal = document.getElementById('reserveModal');
        const copyModal = document.getElementById('copyModal');

        function closeModal() { 
            document.querySelectorAll('.modal-overlay').forEach(el => el.classList.remove('active'));
        }

        window.openReserveModal = function(id, title) {
            document.getElementById('res_art_id').value = id;
            document.getElementById('res_art_title').value = title;
            reserveModal.classList.add('active');
        }

        window.openCopyModal = function(title) {
            document.getElementById('copyMessage').value = "Hello, I am interested in requesting a copy or similar commission of the artwork: \"" + title + "\". Please contact me with details.";
            copyModal.classList.add('active');
        }

        // 5. Header Logic
        document.addEventListener('DOMContentLoaded', () => {
            const notifBtn = document.getElementById('notifBtn');
            const notifDropdown = document.getElementById('notifDropdown');
            const notifBadge = document.getElementById('notifBadge');
            const notifList = document.getElementById('notifList');
            const markAllBtn = document.getElementById('markAllRead');
            const userDropdown = document.querySelector('.user-dropdown');
            const profilePill = document.querySelector('.profile-pill');

            if (profilePill) {
                profilePill.addEventListener('click', (e) => {
                    e.stopPropagation();
                    userDropdown.classList.toggle('active');
                    if(notifDropdown) notifDropdown.classList.remove('active');
                });
            }
            if (notifBtn) {
                notifBtn.addEventListener('click', (e) => {
                    e.stopPropagation();
                    notifDropdown.classList.toggle('active');
                    if(userDropdown) userDropdown.classList.remove('active');
                });
                
                fetch('fetch_notifications.php').then(r=>r.json()).then(d=>{
                    if(d.status==='success' && d.unread_count > 0) {
                        document.getElementById('notifBadge').style.display='block';
                        document.getElementById('notifBadge').innerText=d.unread_count;
                        let list = document.getElementById('notifList');
                        list.innerHTML='';
                        d.notifications.forEach(n=>{
                            list.innerHTML+=`
                                <li class="notif-item">
                                    <div class="notif-msg">${n.message}</div>
                                    <button class="btn-notif-close">×</button>
                                </li>`;
                            list.lastElementChild.querySelector('.btn-notif-close').addEventListener('click', (e) => {
                                e.stopPropagation();
                                if(confirm('Delete notification?')) {
                                    const fd = new FormData(); fd.append('id', n.id);
                                    fetch('delete_notifications.php', {method:'POST', body:fd})
                                        .then(r=>r.json()).then(d=>{ if(d.status==='success') location.reload(); });
                                }
                            });
                        });
                    }
                });
            }
            window.addEventListener('click', () => {
                if(notifDropdown) notifDropdown.classList.remove('active');
                if(userDropdown) userDropdown.classList.remove('active');
            });
        });
    </script>
</body>
</html>
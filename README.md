# search hospital
## database
hospitals.sql
### version
```
➜  searchHospitalDemo mysql --version
mysql  Ver 8.0.27 for macos11 on x86_64 (MySQL Community Server - GPL)
```

```
mkdir searchHospitalDemo
```
## backend 
### version
```
➜  searchHospitalDemo php --version
WARNING: PHP is not recommended
PHP is included in macOS for compatibility with legacy software.
Future versions of macOS will not include PHP.
PHP 7.3.29-to-be-removed-in-future-macOS (cli) (built: Aug 29 2022 08:54:14) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.29, Copyright (c) 1998-2018 Zend Technologies
```
### create ==composer.json==
```
{
    "require": {
        "slim/slim": "^3.0"
    }
}

```

### install 
```
composer install
```
## create index.php
### index.php
```
<?php

require __DIR__ . '/vendor/autoload.php';
//require 'CORS.php';

//use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Tuupola\Middleware\CorsMiddleware;

// 创建 Slim 应用
$app = new \Slim\App;

// 添加一个中间件来处理 CORS
$app->options('/{routes:.+}', function ($request, $response, $args) {
    return $response;
});

// 中间件来处理跨域请求
$app->add(function ($request, $response, $next) {
    $response = $next($request, $response);
    return $response
        ->withHeader('Access-Control-Allow-Origin', '*')
        ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
});
  
// 定义搜索路由
$app->get('/search', function (Request $request, Response $response) {
    // 获取搜索关键字
    $keyword = $request->getQueryParams()['keyword'];
    
    // 连接到数据库
    $mysqli = new mysqli("127.0.0.1", "root", "Hans1234", "hospitals");

    if ($mysqli->connect_error) {
        die("数据库连接失败: " . $mysqli->connect_error);
    }

    $keyword = $mysqli->real_escape_string($keyword);

    $query = "SELECT H.hospital_name AS HospitalName, D.department_name AS DepartmentName, DR.doctor_name AS DoctorName
              FROM Hospitals H
              JOIN Departments D ON H.hospital_id = D.hospital_id
              JOIN Doctors DR ON D.department_id = DR.department_id
              WHERE D.keywords LIKE '%$keyword%'";

    $result = $mysqli->query($query);

    $data = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
    }

    $mysqli->close();

    // 返回搜索结果
    return $response->withJson($data);
});

// 运行 Slim 应用
$app->run();
  

```
### run
```
php -S localhost:4001
```
test will chrome
```
[Link](￼)
```
[Link](http://localhost:4001/search)
### postman test
![image](CleanShot%202023-10-15%20at%2017.21.45@2x.png)
### web view

```
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
</head>
<body>
<h1>Search Results</h1>
<p>Please enter a keyword:</p>
<input type="text" id="keywordInput">
<button id="searchButton">Search</button>
<div id="results">
    <!-- Search results will be displayed here -->
</div>

<script>
    document.getElementById('searchButton').addEventListener('click', function() {
        var keyword = document.getElementById('keywordInput').value;
        var resultsDiv = document.getElementById('results');
        resultsDiv.innerHTML = 'Loading...';

        // 对关键字进行 URL 编码
        var encodedKeyword = encodeURIComponent(keyword);

        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'http://localhost:4000/search?keyword=' + encodedKeyword, true);
        xhr.responseType = 'json';

        xhr.onload = function() {
            if (xhr.status === 200) {
                var data = xhr.response;
                displayResults(data);
            } else {
                resultsDiv.innerHTML = 'Error: ' + xhr.statusText;
            }
        };

        xhr.send();
    });

    function displayResults(data) {
        var resultsDiv = document.getElementById('results');
        resultsDiv.innerHTML = '';

        if (data.length === 0) {
            resultsDiv.innerHTML = '<p>No results found.</p>';
        } else {
            var resultHtml = '<ul>';
            data.forEach(function(item) {
                resultHtml += '<li>' + item.HospitalName + ' - ' + item.DepartmentName + ' - ' + item.DoctorName + '</li>';
            });
            resultHtml += '</ul>';
            resultsDiv.innerHTML = resultHtml;
        }
    }
</script>
</body>
</html>

```
![image](CleanShot%202023-10-15%20at%2017.24.19@2x.png)
> develop tools: **PHPStorm 2020.1**
## file tree
```
➜  searchHospitalDemo tree
.
├── composer.json
├── composer.lock
├── index.html
├── index.php
└── vendor
```

## ref code
[GitHub - Bruends/simple-php-restful-api: :books: Simple Books api with php, slim framework and MySQL](https://github.com/Bruends/simple-php-restful-api/tree/master)
[GitHub - hh404/searchHospitalDemo](https://github.com/hh404/searchHospitalDemo)
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
  

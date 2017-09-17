<?php

require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

$bucket = 'perkbox-devops-test';
$s3 = new S3Client([
    'version' => 'latest',
    'region'  => 'eu-west-2'
]);

try {
    $result = $s3->listObjects(array('Bucket' => $bucket));

    foreach ($result['Contents'] as $object) {
        echo $object['Key'] . "\n";
    }
} catch (S3Exception $e) {
    echo $e->getMessage() . "\n";
}

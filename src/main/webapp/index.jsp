<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Title of the document</title>
<script src="js/vue2.4.0.js"></script>
<script src="js/jquery2.2.4.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
<script>
	function hello(res) {
		console.log(res);
	}
	function jsonpFn() {
		var script = document.createElement('script');
		var url = 'http://127.0.0.1:8080/jsonp?callback=hello';
		script.src = url;
		document.getElementsByTagName('head')[0].appendChild(script);
	}
</script>
</head>

<body>
	<!-- @RequestMapping("/jsonp") public String jsonp(String callback) { return
	"hello(111)"; } -->
	<input type="button" id="testJsonp" onclick="jsonpFn();"
		value="testjsonpjs" />

	<div id="app">
		<input type="file" id="file01" /> <input type="file" id="file02" />
		<input type="file" id="file" name="file" multiple>
		<button @click="get">get</button>
		<button @click="login">login</button>
		<button @click="postformdata">postformdata</button>
		<button @click="postformdataMulti">postformdataMulti</button>
		<button @click="testchinese">testchinese</button>
		<button @click="jsonp">jsonp</button>






	</div>
	<script>
		Vue.http.options.credentials = true;
		var vm = new Vue(
				{
					el : "#app",
					data : {},
					methods : {
						get : function() {
							//发送get请求
							this.$http
									.get(
											'http://127.0.0.1:8080/xvkang/upfile/progress',
											{
												params : {
													parentId : "root"
												}
											}).then(function(res) {
										console.log(res);
									}, function() {
										console.log('请求失败处理');
									});
							this.$http.get('http://127.0.0.1:8080/test', {
								params : {
									parentId : "root"
								}
							}).then(function(res) {
								console.log(res);
							}, function() {
								console.log('请求失败处理');
							});
						},
						post : function() {
							//发送 post 请求
							this.$http.post('/try/ajax/demo_test_post.php', {
								name : "",
								url : "http://www.runoob.com"
							}, {
								credentials : true
							}).then(function(res) {
								document.write(res.body);
							}, function(res) {
								console.log(res.status);
							});
						},
						login : function() {
							//发送 post 请求
							this.$http.post(
									'http://111.225.203.10:8080/nyzft/login', {
										username : "hs_test",
										password : "123456"
									}, {
										credentials : true,
										emulateJSON : true
									}).then(function(res) {
								console.log(res);
							}, function(res) {
								console.log('请求失败处理');
								console.log(res.status);
							});
						},
						testchinese : function() {
							this.$http.post('http://127.0.0.1:8080/test', {
								username : "吴佳同",
								password : "123456"
							}, {
								credentials : true,
								emulateJSON : true
							}).then(function(res) {
								console.log(res);
							}, function(res) {
								console.log('请求失败处理');
								console.log(res.status);
							});
						},
						postformdata : function() {
							var formData = new FormData()
							//formData.append('name','test');
							let photo = document.getElementById('file01');
							let photo2 = document.getElementById('file02');
							formData.append('file01', photo.files[0]);
							formData.append('file02', photo2.files[0]);
							this.$http
									.post(
											'http://127.0.0.1:8080/xvkang/upfile/upload',
											formData,
											{
												credentials : true,
												'Content-Type' : 'Multipart/form-data'
											}).then(function(res) {
										console.log(res);
									}, function(res) {
										console.log('upload 请求失败处理');
										console.log(res.status);
									});
							/* var httpTmp= this.$http;
							var timer = setInterval(function() {
								httpTmp.get('http://127.0.0.1:8080/xvkang/upfile/progress', { params: { parentId: "root" } }).then(function (res) {
							         console.log(res);
							     }, function () {
							         console.log('progress 请求失败处理');
							     });
								}, 10000); */

						},
						postformdataMulti : function() {
							var formData = new FormData()
							formData.append('test', "test");
							formData.append('test', "test");
							formData.append('test', "test");
							let photo = document.getElementById('file');
							for (var i = 0; i < photo.files.length; i++) {
								var file = photo.files[i];
								// Add the file to the request.
								formData.append('file', file);
							}
							//formData.append('file', photo.files);
							formData.append('test', "test");
							this.$http
									.post(
											'http://127.0.0.1:8080/xvkang/upfile/uploadMulti?uuid=uuid04&totalItems=6',
											formData,
											{
												credentials : true,
												'Content-Type' : 'Multipart/form-data'
											}).then(function(res) {
										console.log(res);
									}, function(res) {
										console.log('upload 请求失败处理');
										console.log(res.status);
									});
							var httpTmp = this.$http;
							var timer = setInterval(
									function() {
										httpTmp
												.get(
														'http://127.0.0.1:8080/xvkang/upfile/progress',
														{
															params : {
																key : "uuid04"
															}
														})
												.then(
														function(res) {
															console.log(res);
														},
														function() {
															console
																	.log('progress 请求失败处理');
														});
									}, 1000);

						},
						jsonp : function() {
							this.$http
									.jsonp(
											'http://127.0.0.1:8080/jsonp?callback=hello',
											{
												jsonp : "hello"
											}, {
												headers : {},
												emulateJSON : true
											}).then(function(response) {
										console.log(response);
									}, function(response) {
										console.log(response);
									});
						}
					}
				});
	</script>
</body>

</html>

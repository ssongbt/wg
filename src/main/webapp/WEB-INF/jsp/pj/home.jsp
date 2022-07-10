<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Home</title>
<style>
		header {
			  position: fixed;
			  top: 0;
			  left: 0;
			  right: 0;
			  
			  height: 75px;
			  padding: 1rem;
			  color: #dbd8d1;
			  background: #baa289;
			  font-weight: bold;
			  display: flex;
			  justify-content: space-between;
			  align-items: center;
			}
	a { text-decoration:none; color:#dbd8d1; font-weight:lighter; }
	body { padding-top: 130px; background: #EEE; }
	body, html {	height: 100%;	}
	.level { 
			 position: relative;
			  z-index: 1;
			  background: #dbd8d1;
			  max-width: 360px;
			  margin: 0 auto 100px;
			  padding: 45px;
			  text-align: center;}
	.level>img { width:200px; }
	#theater { font-weight:bold; color:#56473c;  font-size:20px; margin-bottom:10px; }
	#point { font-weight:bold; color:#56473c;  }
	#year { width:90px; height:20px;  appearance: none; -webkit-appearance: none; text-align:center; color:#56473c;}
	#year::-ms-expand { display:none; }
	#chart { margin:0 auto;}
	.select { float:right; margin-right:300px; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script>

</script>
</html>
</head>
<body>
<header>
  <h1><img src="/images/logo.png"></a></h1>
  <nav>
    <span><a href="/wg/list">공연</a></span>
    <span> ｜ </span>
    <span><a href="/wg/mylist">나의 극장</a></span>
    <span> ｜ </span>
    <span><a href="/wg/myinfo">내 정보</a></span>
  </nav>
</header>
<div class="level">
<h4>${user.nick} 님의 레벨</h4>
<c:choose>
<c:when test="${countPer<=300}"><div id="theater">소극장</div><img src="/images/small.png">
<p id="message">다음 레벨까지 <a id="point">${300-countPer}</a>자리 남았습니다</p>
</c:when>
<c:when test="${countPer>300 && countPer<1000 }"><div id="theater">중극장</div><img src="/images/middle.png">
<p id="message">다음 레벨까지<a id="point">${1000-countPer}</a>자리 남았습니다</p>
</c:when>
<c:when test="${countPer>=1000}"><div id="theater">대극장</div><img src="/images/big.png">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>

<div>관람한 극 수 ｜ <a id="point">${countPer}</a></div>
<div>가본 극장 수 ｜ <a id="point">${countLoc}</a></div>


</div>
<div class="select">
<form action="" method="post">
<select id="year" name="year" onchange="changeYear();">
	<option value="2022" selected="selected">2022</option>
	<option value="2021">2021</option>
	<option value="2020">2020</option>
	<option value="2019">2019</option>
	<option value="2018">2018</option>
	<option value="2017">2017</option>
</select>
</form>

</div>
<div id="chart" style="width: 700px; height: 700px;">
<input type="hidden" name="year" value="year"/>
	<!--차트가 그려질 부분-->
	<canvas id="myChart"></canvas>
</div>



<div id="res">
  
</div>

<script type="text/javascript">

function changeYear(){
	
	//var year = "";
	
	//var select = document.getElementById("year");
	//year = select.options[select.selectedIndex].value;
	
	var year = $('#year').val();
	
	//alert(year+'연도');
	
	
	var obj={}
	obj.year = year;

	$.ajax({
		url:'/wg/home',
		method :'post',
		cache:false,
		data : {year:year},
		dataType: 'json',
		success: function(res){
			//alert(year);
			//alert(alldata);
			//alert(res.year);
			//alert(res.count1);
			var context = document
		    .getElementById('myChart')
		    .getContext('2d');
			var myChart = new Chart(context, {
		    type: 'bar', // 차트의 형태
		    data: { // 차트에 들어갈 데이터
		        labels: [
		            //x 축
		            '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'
		        ],
		        datasets: [
		            { //데이터
		                label: '월별 관람 횟수', //차트 제목
		                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
		                data: [
		                	(res.count1), (res.count2), (res.count3), (res.count4), (res.count5), (res.count6), (res.count7), (res.count8), (res.count9), (res.count10), (res.count11), (res.count12) //x축 label에 대응되는 데이터 값
		                ],
		                backgroundColor: [
		                    //색상
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)',
		                    'rgba(141, 151, 202, 0.3)'
		                ],
		                borderColor: [
		                    //경계선 색상
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)',
		                    'rgba(61, 63, 97, 1)'
		                ],
		                borderWidth: 1 //경계선 굵기
		            }/* ,
		            {
		                label: 'test2',
		                fill: false,
		                data: [
		                    8, 34, 12, 24
		                ],
		                backgroundColor: 'rgb(157, 109, 12)',
		                borderColor: 'rgb(157, 109, 12)'
		            } */
		        ]
		    },
		    options: {
		        scales: {
		            yAxes: [
		                {
		                    ticks: {
		                        beginAtZero: true
		                    }
		                }
		            ]
		        }
		    }
		});
		},
		 error: function(xhr, status, err){
			   alert("에러:" + err);
		   }
	});
	
	
}

	var context = document
	.getElementById('myChart')
	.getContext('2d');
	var myChart = new Chart(context, {
	type: 'bar', // 차트의 형태
	data: { // 차트에 들어갈 데이터
	    labels: [
	        //x 축
	    	'1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'
	    ],
	    datasets: [
	        { //데이터
	            label: '월별 관람 횟수', //차트 제목
	            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
	            data: [
	            	${count1}, ${count2}, ${count3}, ${count4}, ${count5}, ${count6}, ${count7}, ${count8}, ${count9}, ${count10}, ${count11}, ${count12} //x축 label에 대응되는 데이터 값
	            ],
	            backgroundColor: [
	                //색상
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)',
	                'rgba(141, 151, 202, 0.3)'
	            ],
	            borderColor: [
	                //경계선 색상
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)',
	                'rgba(61, 63, 97, 1)'
	            ],
	            borderWidth: 1 //경계선 굵기
	        }/* ,
	        {
	            label: 'test2',
	            fill: false,
	            data: [
	                8, 34, 12, 24
	            ],
	            backgroundColor: 'rgb(157, 109, 12)',
	            borderColor: 'rgb(157, 109, 12)'
	        } */
	    ]
	},
	options: {
	    scales: {
	        yAxes: [
	            {
	                ticks: {
	                    beginAtZero: true
	                }
	            }
	        ]
	    }
	}
	});
           
</script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<title>Maple Calculator</title>

<!-- css 링크 가져오기 -->
<jsp:include page="../Snippets/Css.jsp" />
<link rel="stylesheet" href="../Home/Home.css">
</head>

<body>
	<!-- Header 불러오기 -->
	<jsp:include page="../Snippets/Header.jsp" />

	<!-- 배경 이미지 -->
	<div class="background-img">
		<img src="Home_img/background.jpg" alt="background-image" style="display: block; width: 100%;" />
	</div>

	<!-- 계산기/시뮬레이터로 이동 -->
	<div class="container marketing">
		<div class="row" style="margin: 50px auto;">
			<div class="col-lg-4">
				<svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false">
                    <image href="Home_img/maple.png" width="100%" height="100%" />
                </svg>
				<h3 class="explain-title"><b style="color:orangered;">스탯 효율 계산기</b></h3>
				<p class="explain-massage">		
					&nbsp;&nbsp;&nbsp;&nbsp;누구나 한 번씩 에디셔널 잠재능력 옵션 중에 '캐릭터 레벨 10당 STR +1'과 'STR +1%' 중 어떤 효과가 더 좋은지 고민해보지 않았을까? 내 장갑에 달린 '크리티컬 데미지 +8%'가 정확히 주스탯 몇%인지 궁금하지 않았는가? 복잡한 스펙 효율 계산을 쉽고 간편하게 수행하는 계산기를 만들었다.
				</p>
				<button type="button" class="btn btn-primary position-relative btn-start" onclick="location.href='../MapleStatCalculator/StatCalculator.jsp'">START
					<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">HOT</span>
				</button>
			</div>
			<div class="col-lg-4">
				<svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false">
                    <image href="Home_img/cube.jpg" width="100%" height="100%" />
                </svg>
				<h3 class="explain-title"><b>큐브 시뮬레이터</b></h3>
				<p class="explain-massage">
					&nbsp;&nbsp;&nbsp;&nbsp;메이플스토리에서 제공하는 확률형 아이템 > 큐브의 옵션 등급 설정 확률, 등급 상승 확률을 고려하여 원하던 아이템에 원하는 큐브를 원하는 만큼 사용했을 때 등장하는 옵션을 확인할 수 있도록 시뮬레이터를 만들었다. 장인의 큐브/명장의 큐브 메소가격을 기재하면 총 사용한 큐브의 비용도 계산할 수 있다.
				</p>
				<button type="button" class="btn btn-primary position-relative btn-start" onclick="location.href='#'" style="cursor: not-allowed; background-color: black; border-color: black;" >READY
					<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-dark"><small>Coming Soon</small></span>
				</button>
			</div>
			<!-- /.col-lg-4 -->
			<div class="col-lg-4">
				<svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false">
                    <image href="Home_img/EternalRebirthFlame.webp" width="100%" height="100%" />
                </svg>
				<h3 class="explain-title"><b>환생의 불꽃 시뮬레이터</b></h3>
				<p class="explain-massage">
					&nbsp;&nbsp;&nbsp;&nbsp;강력한 환생의 불꽃/영원한(검은) 환생의 불꽃을 본인이 원하는 아이템에 사용하며 환생의 불꽃이 사용됨에 따른 추가옵션을 예상하여 제공한다. 환생의 불꽃의 메소 가격을 적는다면 원하는 옵션이 뜰 때까지 사용된 환생의 불꽃 총 가격을 계산해준다.<br/><br/>
				</p>
				<button type="button" class="btn btn-primary position-relative btn-start" onclick="location.href='#'" style="cursor: not-allowed; background-color: black; border-color: black;" >READY
					<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-dark"><small>Coming Soon</small></span>
				</button>
			</div>
		</div>

		<!-- START THE FEATURETTES -->
		<hr class="featurette-divider">

		<div class="row featurette" style="margin: 50px auto;">
			<div class="col-md-7">
				<h2 class="featurette-heading">히어로 <span class="text-muted"><small>Hero</small></span></h2>
				<p class="lead">
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br /><br />
					&nbsp;&nbsp;&nbsp;&nbsp;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</p>
			</div>
			<div class="col-md-5">
				<svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false">
                    <image href="../MapleStatCalculator/StatCalculator_img/job/hero.png" width="100%" height="100%" />
                </svg>
			</div>
		</div>

		<hr class="featurette-divider">

		<div class="row featurette" style="margin: 50px auto;">
			<div class="col-md-7 order-md-2">
				<h2 class="featurette-heading">아크메이지(불,독) <span class="text-muted"><small>Magician(Fire,Poison)</small></span></h2>
				<p class="lead">
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br /><br />
					&nbsp;&nbsp;&nbsp;&nbsp;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</p>
			</div>
			<div class="col-md-5 order-md-1">
				<svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false">
                    <image href="../MapleStatCalculator/StatCalculator_img/job/magician(fire,poison).png" width="100%" height="100%" />
                </svg>

			</div>
		</div>

		<hr class="featurette-divider">

		<div class="row featurette" style="margin: 50px auto;">
			<div class="col-md-7">
				<h2 class="featurette-heading">비숍 <span class="text-muted"><small>Bishop</small></span></h2>
				<p class="lead">
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br /><br />
					&nbsp;&nbsp;&nbsp;&nbsp;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</p>
			</div>
			<div class="col-md-5">
				<svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false">
                    <image href="../MapleStatCalculator/StatCalculator_img/job/bishop.png" width="100%" height="100%" />
                </svg>
			</div>
		</div>

		<hr class="featurette-divider">
	</div>
	<!-- /END THE FEATURETTES -->

	<!-- carousel -->
	<main>
		<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class=" carousel-indicators">
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                        <rect width="100%" height="100%" fill="grey" />
                    </svg>
					<div class="container">
						<div class="carousel-caption">
							<h2>2022.08.24 정규 업데이트</h2>
							<p style="color: black; font-weight: bold;">아크, 은월 스탯 효율 계산기
								추가&nbsp;&nbsp; &middot; &nbsp;&nbsp;큐브 시뮬레이터(장인의 큐브/명장의 큐브) 기능
								추가</p>
						</div>
					</div>
				</div>
				<div class=" carousel-item">
					<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                        <rect width="100%" height="100%" fill="grey" />
                    </svg>
					<div class="container">
						<div class="carousel-caption">
							<h2>2022.08.24 정규 업데이트</h2>
							<p style="color: black; font-weight: bold;">카데나, 듀얼블레이드 스탯 효율
								계산기 추가&nbsp;&nbsp; &middot; &nbsp;&nbsp;스타포스 시뮬레이터 일부 오류 수정</p>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                        <rect width="100%" height="100%" fill="grey" />
                    </svg>
					<div class="container">
						<div class="carousel-caption">
							<h2>2022.08.24 정규 업데이트</h2>
							<p style="color: black; font-weight: bold;">데몬어벤져 스탯 효율 계산기 추가</p>
						</div>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden"></span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden"></span>
			</button>
		</div>

		<hr class="featurette-divider">

		<!-- Footer 불러오기 -->
		<jsp:include page="../Snippets/Footer.jsp" />
	</main>

	<!-- Script 불러오기 -->
	<jsp:include page="../Snippets/Script.jsp" />

</body>

</html>
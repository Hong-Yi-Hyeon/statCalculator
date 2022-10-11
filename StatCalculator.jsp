<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스탯 효율 계산기</title>

<!-- css 링크 가져오기 -->
<jsp:include page="../Snippets/Css.jsp" />
<link href="StatCalculator.css" rel="stylesheet">
</head>

<body>
	<!-- Header 불러오기 -->
	<jsp:include page="../Snippets/Header.jsp" />
	<script>
		function handleOnInput(el, maxlength) {
  			if(el.value.length > maxlength)  {
   		 		el.value = el.value.substr(0, maxlength);
 			}
		}
		
		function getCheckedCnt()  {
			// 선택된 목록 가져오기
			const query = 'input[name="linkSkills"]:checked';
			const selectedElements = 
			document.querySelectorAll(query);

			// 선택된 목록의 갯수 세기
			const selectedElementsCnt = selectedElements.length;

			// 출력
			document.getElementById('result').innerText = selectedElementsCnt;
		}
	</script>

	<form class="StatCalculatorForm" action="StatCalculatorProcess.jsp" method="post" name="ShadeForm" style="padding: 10px;">
		
		<h2 style="color:orangered; font-weight:bold; line-height:200%;">메이플스토리 스탯계산기&nbsp;<span style="color: orange; font-size: 16px;">MapleStory StatCalculator</span></h2>
		
		<h4 class="information_msg">①&nbsp;&nbsp;직업 <small>&</small> 스탯 관련 정보</h4>
		<p>
			전직업이 모든 온오프스킬과 메이플용사, 영웅의 메아리, 쓸만한 스킬을 포함한 모든 스킬을 사용하지 않은 <span style="color:red;">순수 노버프 상태에서 측정</span>하는 것을 원칙으로 제작하였습니다.<br />
			평소 보스를 가기 전 사용하시는 링크스킬 그대로 착용하시길 권장드립니다. 시드링을 사용하시는 경우, 시드링을 착용하신 상태에서 측정해주세요.<br />
			몬스터라이프에 '쁘띠 루미너스(이퀄리브리엄)'가 있다면 창고에 넣은 후 계산기를 사용해주세요. 펫이 자동으로 스킬을 사용하는 경우, 주변에서 기상효과 등으로 스탯공격력에 영향을 미치는 경우 등을 조심해주세요.<br />
			<small>* 제로 직업군의 경우 알파 상태에서 계산기를 사용해주세요.</small> 
		</p>
			<div class="row row-cols-auto">
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/job/job.png" class="card-img-top" alt="직업">
					<div class="card-body">
						<h5 class="card-title">직업</h5>
						<p class="card-text" style="margin-bottom: 34px">캐릭터의 직업을 선택하세요.</p>
						<select id="selectBox" name="job" class="inputData">
							<optgroup label="전사"></optgroup>
								<option value="hero" selected="selected">&nbsp;히어로</option>
								<option value="paladin">&nbsp;팔라딘</option>
								<option value="darkKnight">&nbsp;다크나이트</option>
								<option value="mihile">&nbsp;미하일</option>
								<option value="dawnWarrior">&nbsp;소울마스터</option>
								<option value="demonAvenger" style="color: red;" disabled>&nbsp;데몬어벤져</option>
								<option value="demonSlayer">&nbsp;데몬슬레이어</option>
								<option value="blaster">&nbsp;블래스터</option>
								<option value="aran">&nbsp;아란</option>
								<option value="kaiser">&nbsp;카이저</option>
								<option value="adele">&nbsp;아델</option>
								<option value="zero">&nbsp;제로</option>
								<option value="blank_1" disabled></option>
							<optgroup label="마법사"></optgroup>
								<option value="magician(fire,poison)">&nbsp;아크메이지(불,독)</option>
								<option value="magician(ice,lightning)">&nbsp;아크메이지(썬,콜)</option>
								<option value="bishop">&nbsp;비숍</option>
								<option value="blazeWizard">&nbsp;플레임위자드</option>
								<option value="battleMage">&nbsp;배틀메이지</option>
								<option value="evan">&nbsp;에반</option>
								<option value="luminous">&nbsp;루미너스</option>
								<option value="illium">&nbsp;일리움</option>
								<option value="lara">&nbsp;라라</option>
								<option value="kinesis">&nbsp;키네시스</option>
								<option value="blank_2" disabled></option>
							<optgroup label="궁수"></optgroup>
								<option value="bowmaster">&nbsp;보우마스터</option>
								<option value="marksman">&nbsp;신궁</option>
								<option value="pathfinder">&nbsp;패스파인더</option>
								<option value="windArcher">&nbsp;윈드브레이커</option>
								<option value="wildHunter">&nbsp;와일드헌터</option>
								<option value="mercedes">&nbsp;메르세데스</option>
								<option value="kain">&nbsp;카인</option>
								<option value="blank_3" disabled></option>
							<optgroup label="도적"></optgroup>
								<option value="nightLords">&nbsp;나이트로드</option>
								<option value="shadowers">&nbsp;섀도어</option>
								<option value="dualBlade">&nbsp;듀얼블레이드</option>
								<option value="nightWalker">&nbsp;나이트워커</option>
								<option value="xenon" style="color: red;" disabled>&nbsp;제논</option>
								<option value="phantom">&nbsp;팬텀</option>
								<option value="cadena">&nbsp;카데나</option>
								<option value="hoyoung">&nbsp;호영</option>
								<option value="blank_4" disabled></option>
							<optgroup label="해적"></optgroup>
								<option value="buccaneer">&nbsp;바이퍼</option>
								<option value="corsair">&nbsp;캡틴</option>
								<option value="cannoneer">&nbsp;캐논슈터</option>
								<option value="thunderBreaker">&nbsp;스트라이커</option>
								<option value="mechanic">&nbsp;메카닉</option>
								<option value="shade">&nbsp;은월</option>
								<option value="angelicBuster">&nbsp;엔젤릭버스터</option>
								<option value="ark">&nbsp;아크</option>
						</select>
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/levelUp.gif" class="card-img-top" alt="레벨">
					<div class="card-body">
						<h5 class="card-title">레벨</h5>
						<p class="card-text" style="margin-bottom: 34px">캐릭터의 레벨을 입력하세요.</p>
						<input type="number" name="level" min="140" max="300" oninput="handleOnInput(this, 3)" placeholder="&nbsp;275" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/statAtt.jpg" class="card-img-top" alt="스탯 공격력">
					<div class="card-body">
						<h5 class="card-title">스탯 공격력</h5>
						<p class="card-text">하단의 스탯공격력<small>(더 큰 값)</small>을 입력하세요.</p>
						<input type="number" name="statAtt" min="0" max="1000000000"  oninput="handleOnInput(this, 9)" placeholder="&nbsp;1562292" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/mapleWarrior.gif" class="card-img-top" alt="주스탯">
					<div class="card-body">
						<h5 class="card-title">주스탯 <small>(메용 on)</small></h5>
						<p class="card-text">'메이플 용사'만 사용한 상태의 주스탯 값을 입력하세요.</p>
						<input type="number" name="mainStatUsedMW" min="4" max="100000" oninput="handleOnInput(this, 5)" placeholder="&nbsp;51000" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/str.png" class="card-img-top" alt="주스탯">
					<div class="card-body">
						<h5 class="card-title">주스탯 <small>(메용 off)</small></h5>
						<p class="card-text">모든 버프가 해제된 상태의 주스탯 값을 입력하세요.</p>
						<input type="number" name="mainStatDisusedMW" min="4" max="100000"  oninput="handleOnInput(this, 5)" placeholder="&nbsp;35000" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/dex.png" class="card-img-top" alt="부스탯">
					<div class="card-body">
						<h5 class="card-title">부스탯</h5>
						<p class="card-text" style="margin-bottom: 32px">부스탯 값을 입력하세요.</p>
						<input type="number" name="subStat" min="4" max="100000" oninput="handleOnInput(this, 5)" placeholder="&nbsp;3500" class="inputData" required />
					</div>
				</div>
			</div>
		
		<hr>
		
		<h4 class="information_msg">②&nbsp;&nbsp;스탯%의 적용을 받지 않는 스탯</h4>
			<div class="row row-cols-auto">
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/union.png" class="card-img-top" alt="유니온 공격대원">
					<div class="card-body">
						<h5 class="card-title">유니온 공격대원</h5>
						<p class="card-text">공격대원 효과로 증가한 주스탯 합을 입력하세요. <small>(공격대 점령효과 X)</small></p>
						<input type="number" name="unionStat" min="0" max="835" oninput="handleOnInput(this, 3)" placeholder="&nbsp;630" step="10" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/hyperStat.jpg" class="card-img-top" alt="하이퍼 스탯">
					<div class="card-body">
						<h5 class="card-title">하이퍼 스탯</h5>
						<p class="card-text">하이퍼 스탯으로 증가한 주스탯을 입력하세요.</p>
						<input type="number" name="hyperStat" min="0" max="435" oninput="handleOnInput(this, 3)" placeholder="&nbsp;90" step="30" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/ability.jpg" class="card-img-top" alt="어빌리티">
					<div class="card-body">
						<h5 class="card-title">어빌리티</h5>
						<p class="card-text">어빌리티에 있는 주스탯의 합을 입력하세요.</p>
						<input type="number" name="abilityStat" min="0" max="100" oninput="handleOnInput(this, 3)" placeholder="&nbsp;0" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/arcaneSymbol.jpg" class="card-img-top" alt="아케인심볼">
					<div class="card-body">
						<h5 class="card-title">아케인심볼</h5>
						<p class="card-text">아케인심볼로 증가한 스탯을 입력하세요. <small>(아케인포스 X)</small></p>
						<input type="number" name="arcaneStat" min="0" max="13200" step="100" placeholder="&nbsp;13200" oninput="handleOnInput(this, 5)" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/authenticSymbol.jpg" class="card-img-top" alt="어센틱심볼">
					<div class="card-body">
						<h5 class="card-title">어센틱심볼</h5>
						<p class="card-text">어센틱심볼로 증가한 스탯을 입력하세요. <small>(어센틱포스 X)</small></p>
						<input type="number" name="authenticStat" min="0" max="7350" step="100" placeholder="&nbsp;3300" oninput="handleOnInput(this, 4)" class="inputData" required />
					</div>
				</div>
			</div>
			
		<hr>
			
		<h4 class="information_msg">③&nbsp;&nbsp;공격력/마력%&nbsp;&nbsp;<small>&</small>&nbsp;&nbsp;데미지류&nbsp;&nbsp;<small>&</small>&nbsp;&nbsp;방어율 무시</h4>
		<p>공격력/마력%는 직접 무기, 보조무기, 엠블렘을 확인하시며 계산하셔야 합니다. 나머지는 <span style="color:red;">상세스탯창에 기재된 값을 그대로 입력</span>하시면 됩니다.<br />상세스탯창의 값도 반올림된 값이기 때문에 그대로 적어도 <span style="color:orange;">미세한 오차는 발생</span>할 수 있습니다. 최대한 정확한 수치를 추산할 수 있기 위해 있는 그대로의 값을 기재해주세요.</p>	
			<div class="row row-cols-auto">
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/attPercent.jpg" class="card-img-top" alt="공격력 %">
					<div class="card-body">
						<h5 class="card-title">공격력/마력 %</h5>
						<p class="card-text">무기, 보조무기, 엠블렘의 잠재능력에 있는 공격력/마력 %의 합을 입력하세요. 만약, 장착한 소울에 공격력 +3% 옵션이 있다면 더해주세요.</p>
						<input type="number" name="attPercent" min="0" max="219" placeholder="&nbsp;108" oninput="handleOnInput(this, 3)" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/damage.jpg" class="card-img-top" alt="데미지">
					<div class="card-body">
						<h5 class="card-title">데미지</h5>
						<p class="card-text">상세스탯 좌측 상단의 데미지를 입력하세요. 보스데미지, 크리데미지, 최종데미지 등은 따로 계산하니 합산하지 말고, 데미지만을 입력하세요.</p>
						<input type="number" name="damage" min="0" max="1000" placeholder="&nbsp;86" oninput="handleOnInput(this, 3)" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/bossDamage.png" class="card-img-top" alt="보스데미지">
					<div class="card-body">
						<h5 class="card-title">보스 데미지</h5>
						<p class="card-text">상세스탯 우측 상단의 보스데미지를 입력하세요. 링크스킬, 버프, 도핑 등을 따로 적용할 수 있으니 상세스탯창에 적힌 그대로 입력하세요.</p>
						<input type="number" name="bossDamage" min="0" max="1000" placeholder="&nbsp;384" oninput="handleOnInput(this, 3)" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/critDamage.jpg" class="card-img-top" alt="크리데미지">
					<div class="card-body">
						<h5 class="card-title">크리티컬 데미지</h5>
						<p class="card-text">상세스탯 중단의 크리데미지를 입력하세요. 소수점 둘째자리까지 기재되어있지만, 무시하고 버림<small>(반올림 X)</small>하여 소수점 첫째자리까지 입력하세요.</p>
						<input type="number" name="critDamage" min="0" max="350" placeholder="&nbsp;88.0" oninput="handleOnInput(this, 4)" step="0.5" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/afflictedByAbnormalStatusesDamage.png" class="card-img-top" alt="상태 이상에 걸린 대상 공격 시 데미지 증가">
					<div class="card-body">
						<h5 class="card-title">상태이상 데미지</h5>
						<p class="card-text">스탯창 하단의 어빌리티를 확인하여 '상태 이상에 걸린 대상 공격 시 데미지 n% 증가' 옵션이 있다면 n값을 입력해주세요.</p>
						<input type="number" name="afflictedByAbnormalStatusesDamage" min="0" max="8" placeholder="&nbsp;8" oninput="handleOnInput(this, 1)" step="1" class="inputData" required />
					</div>
				</div>
				<div class="card" style="width: 15rem;">
					<img src="StatCalculator_img/ignoreDef.jpg" class="card-img-top" alt="방어율 무시">
					<div class="card-body">
						<h5 class="card-title">방어율 무시</h5>
						<p class="card-text">상세스탯 창에 기재된 방어율 무시값을 임의로 반올림하거나 버림하지 말고, 소수점 둘째자리까지 그대로 입력하세요.</p>
						<input type="number" name="ignoreDef" min="0.00" max="100.00" placeholder="&nbsp;92.39" oninput="handleOnInput(this, 5)" step="0.01" class="inputData" required />
					</div>
				</div>
			</div>

		<hr>

		<h4 class="information_msg">④&nbsp;&nbsp;길드스킬</h4>
		<p>
			길드 UI를 열어 좌측 '길드 스킬'칸을 선택하세요. 길드 스킬 하단에 표시되어 있는 각 '노블레스 길드스킬'의 수치를 입력하세요.<br />
			길드스킬의 <span style="color: red;">스킬 레벨이 아니라</span> 스킬로 인해 오르는 각각의 <span style="color: red;">수치를 적는 것</span>이라는 점을 유의해주세요.<br />
			해당 길드스킬이 없다면 반드시 0을 기재하신 후 넘어가주세요. 아무런 기재도 하지 않은 경우, 내용 제출이 되지 않습니다.
		</p>
			<!-- 길드 스킬 -->
			<div class="row row-cols-auto">
				<div class="card" style="width: 12rem; height: 19rem;">
					<img src="StatCalculator_img/skill/bossSlayers.png" class="skill-img" alt="보스 킬링 머신">
					<div class="card-body">
						<h6 class="card-title">보스 킬링 머신</h6>
						<p class="card-text card-text2">보스 데미지 +0~30%</p>
						<input type="number" name="bossSlayers" min="0" max="30" placeholder="&nbsp;30" oninput="handleOnInput(this, 2)" step="2" class="inputData" required style="width: 135px;" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 19rem;">
					<img src="StatCalculator_img/skill/undeterred.png" class="skill-img" alt="방어력은 숫자일 뿐">
					<div class="card-body">
						<h6 class="card-title">방어력은 숫자일 뿐</h6>
						<p class="card-text card-text2">방어율 무시 +0~30%</p>
						<input type="number" name="undeterred" min="0" max="30" placeholder="&nbsp;0" oninput="handleOnInput(this, 2)" step="2" class="inputData" required style="width: 135px;" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 19rem;">
					<img src="StatCalculator_img/skill/forTheGuild.png" class="skill-img" alt="길드의 이름으로">
					<div class="card-body">
						<h6 class="card-title">길드의 이름으로</h6>
						<p class="card-text card-text2">데미지 +0~30%</p>
						<input type="number" name="forTheGuild" min="0" max="30" placeholder="&nbsp;30" oninput="handleOnInput(this, 2)" step="2" class="inputData" required style="width: 135px;" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 19rem;">
					<img src="StatCalculator_img/skill/bigHit.png" class="skill-img" alt="크게 한방">
					<div class="card-body">
						<h6 class="card-title">크게 한방</h6>
						<p class="card-text card-text2">크리데미지 +0~30%</p>
						<input type="number" name="bigHit" min="0" max="30" placeholder="&nbsp;30" oninput="handleOnInput(this, 2)" step="2" class="inputData" required style="width: 135px;" />
					</div>
				</div>
			</div>

		<hr>

		<h4 class="information_msg">⑤&nbsp;&nbsp;링크스킬</h4>
		<p style="display:inline;">본인의 링크스킬을 포함해서 적용 중인 최대 13개의 링크스킬을 선택해주세요. 현재&nbsp;</p><div id="result" style="display:inline;"></div><p style="display:inline;">개 선택하셨습니다.<br />적용 중이 아니거나 보유하고 있지 않은 링크스킬은 선택하지 말아주세요.</p>
			<!-- 링크 스킬 -->
			<div class="row row-cols-auto">
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/empiricalKnowledge.webp" class="skill-img" alt="임피리컬 널리지">
					<div class="card-body">
						<h6 class="card-title">임피리컬 널리지</h6>
						<p class="card-text card-text2">데미지 +9%,<br />방어율 무시 +9%</p>
						<input type="checkbox" value="empiricalKnowledge" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/thief'sCunning.webp" class="skill-img" alt="시프 커닝">
					<div class="card-body">
						<h6 class="card-title">시프 커닝</h6>
						<p class="card-text card-text2">데미지 +18%<br />(가동률 50%)</p>
						<input type="checkbox" value="thiefsCunning" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/pirateBlessing.webp" class="skill-img" alt="파이렛 블레스">
					<div class="card-body">
						<h6 class="card-title">파이렛 블레스</h6>
						<p class="card-text card-text2">올스탯 +70<br />&nbsp;</p>
						<input type="checkbox" value="pirateBlessing" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/cygnusBlessing.png" class="skill-img" alt="시그너스 블레스">
					<div class="card-body">
						<h6 class="card-title">시그너스 블레스</h6>
						<p class="card-text card-text2">공격력 +25<br />&nbsp;</p>
						<input type="checkbox" value="cygnusBlessing" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/wildRage.png" class="skill-img" alt="와일드 레이지">
					<div class="card-body">
						<h6 class="card-title">와일드 레이지</h6>
						<p class="card-text card-text2">데미지 +10%<br />&nbsp;</p>
						<input type="checkbox" value="wildRage" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/furyUnleashed.png" class="skill-img" alt="데몬스 퓨리">
					<div class="card-body">
						<h6 class="card-title">데몬스 퓨리</h6>
						<p class="card-text card-text2">보스데미지 +15%<br />&nbsp;</p>
						<input type="checkbox" value="furyUnleashed" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/hybridLogic.png" class="skill-img" alt="하이브리드 로직">
					<div class="card-body">
						<h6 class="card-title">하이브리드 로직</h6>
						<p class="card-text card-text2">올스탯 +10%<br />&nbsp;</p>
						<input type="checkbox" value="hybridLogic" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/lightWash.png" class="skill-img" alt="퍼미에이트">
					<div class="card-body">
						<h6 class="card-title">퍼미에이트</h6>
						<p class="card-text card-text2">방어율 무시 +15%<br />&nbsp;</p>
						<input type="checkbox" value="lightWash" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/timeToPrepare.png" class="skill-img" alt="프라이어 프리퍼레이션">
					<div class="card-body">
						<h6 class="card-title" style="font-size:14px;">프라이어 프리퍼레이션</h6>
						<p class="card-text card-text2">데미지 +17%<br />(가동률 약 41%)</p>
						<input type="checkbox" value="timeToPrepare" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/unfairAdvantage.png" class="skill-img" alt="인텐시브 어썰트">
					<div class="card-body">
						<h6 class="card-title">인텐시브 어썰트</h6>
						<p class="card-text card-text2">조건부 데미지 +12%<br />(가정 : 조건 상시 만족)</p>
						<input type="checkbox" value="unfairAdvantage" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/termsAndConditions.png" class="skill-img" alt="소울 컨트랙트">
					<div class="card-body">
						<h6 class="card-title">소울 컨트랙트</h6>
						<p class="card-text card-text2">데미지 +45%<br />(가동률 약 11%)</p>
						<input type="checkbox" value="termsAndConditions" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>	
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/nobleFire.png" class="skill-img" alt="노블레스">
					<div class="card-body">
						<h6 class="card-title">노블레스</h6>
						<p class="card-text card-text2">보스데미지 +6~12%<br />(솔로 플레이 가정)</p>
						<input type="checkbox" value="nobleFire" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/tideOfBattle.png" class="skill-img" alt="전투의 흐름">
					<div class="card-body">
						<h6 class="card-title">전투의 흐름</h6>
						<p class="card-text card-text2">조건부 데미지 +12%<br />(가동률 약 83%)</p>
						<input type="checkbox" value="tideOfBattle" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>	
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/solus.png" class="skill-img" alt="무아">
					<div class="card-body">
						<h6 class="card-title">무아</h6>
						<p class="card-text card-text2">조건부 데미지 +11%<br />(가동률 약 91%)</p>
						<input type="checkbox" value="solus" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/judgement.png" class="skill-img" alt="판단">
					<div class="card-body">
						<h6 class="card-title">판단</h6>
						<p class="card-text card-text2">크리데미지 +4%<br />&nbsp;</p>
						<input type="checkbox" value="judgement" name="linkSkills" onclick='getCheckedCnt()' />
					</div>
				</div>
			</div>

		<hr>

		<h4 class="information_msg">⑥&nbsp;&nbsp;쓸만한 스킬</h4>
		<p>파티 스킬에 있는 샤프 아이즈, 컴뱃 오더스, 어드밴스드 블레스와 함께 사용한 것으로 입력하신 경우, 자동으로 미사용된 것으로 수정하여 결과값이 반영됩니다.</p>
			<!-- 쓸만한 스킬 -->
			<div class="row row-cols-auto">
				<div class="card" style="width: 12rem; height: 18rem;">
					<img src="StatCalculator_img/skill/decentSharpEyes.webp" class="skill-img" alt="쓸만한 샤프아이즈">
					<div class="card-body">
						<h6 class="card-title">쓸만한 샤프 아이즈</h6>
						<p class="card-text card-text2">크리데미지 +8%</p>
						<input type="checkbox" value="decentSharpEyes" name="decentSkills" style="margin-top: 5px;" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 18rem;">
					<img src="StatCalculator_img/skill/decentCombatOrders.webp" class="skill-img" alt="쓸만한 컴뱃 오더스">
					<div class="card-body">
						<h6 class="card-title">쓸만한 컴뱃 오더스</h6>
						<p class="card-text card-text2">직업마다 다르게 적용</p>
						<input type="checkbox" value="decentCombatOrders" name="decentSkills" style="margin-top: 5px;" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 18rem;">
					<img src="StatCalculator_img/skill/decentAdvancedBlessing.webp" class="skill-img" alt="쓸만한 어드밴스드 블레스">
					<div class="card-body">
						<h6 class="card-title" style="font-size:12.5px;">쓸만한 어드밴스드 블레스</h6>
						<p class="card-text card-text2">공격력/마력 +20</p>
						<input type="checkbox" value="decentAdvancedBlessing" name="decentSkills" style="margin-top: 5px;" />
					</div>
				</div>
			</div>
			
		<hr>

		<h4 class="information_msg">⑥&nbsp;&nbsp;파티 스킬</h4>
		<p>
			'영웅의 메아리'는 모든 직업이 가지고 있는 스킬이므로 기본적으로 사용하는 것으로 체크하시길 권장합니다.<br />
			그러나 일부는 쿨타임이 짧은 스킬이므로 상시 유지가 되지 않기 때문에 <span style="color:red;">함께 가는 파티원이 가진 스킬이 아닌 이상 체크하지 않기를 권장</span>합니다.<br />
			자신이 가지고 있는 스킬이라면 당연히 체크합니다. <small style="color: gray;">(노버프 상태 그대로 본인의 직업이 그 스킬을 소지하고 있다면 체크하라는 의미입니다.)</small><br />
			다크나이트는 비홀더스 버프가 공격력 70 증가로 적용되고, 아크는 차지 스펠 앰플리케이션이 2배로 적용됩니다. <small style="color: gray;">(방어율 무시는 40%가 아니라 20% 2회로 적용됩니다.)</small><br />
			직업군별로 수가 달라서 에픽 어드벤쳐, 히어로즈 오쓰, 레이스 오브 갓 등 공용 스킬이 적용될 수 있는 최대치가 다르기 때문에 해당 버프는 파티 스킬란에서 제외했습니다. 
		</p>			
			<!-- 파티 버프 -->
			<div class="row row-cols-auto">
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/spiritBlade.webp" class="skill-img" alt="스피릿 블레이드">
					<div class="card-body">
						<h6 class="card-title">스피릿 블레이드</h6>
						<p class="card-text card-text2">[히어로]<br />공격력 +30</p>
						<input type="checkbox" value="spiritBlade" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/beholdersBuff.png" class="skill-img" alt="비홀더스 버프">
					<div class="card-body">
						<h6 class="card-title">비홀더스 버프</h6>
						<p class="card-text card-text2">[다크나이트]&nbsp;&nbsp;공격력 +35<br /><small>(다크나이트는 공격력 +70)</small></p>
						<input type="checkbox" value="beholdersBuff" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/encourage.png" class="skill-img" alt="인커리지">
					<div class="card-body">
						<h6 class="card-title">인커리지</h6>
						<p class="card-text card-text2">[미하일]<br />공격력 +30</p>
						<input type="checkbox" value="encourage" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/mahaBlessing.webp" class="skill-img" alt="블레싱 마하">
					<div class="card-body">
						<h6 class="card-title">블레싱 마하</h6>
						<p class="card-text card-text2">[아란]<br />공격력/마력 +30</p>
						<input type="checkbox" value="mahaBlessing" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/meditation.webp" class="skill-img" alt="메디테이션">
					<div class="card-body">
						<h6 class="card-title">메디테이션</h6>
						<p class="card-text card-text2">[모험가 마법사]<br />마력 +30</p>
						<input type="checkbox" value="meditation" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/photicMeditation.png" class="skill-img" alt="포틱 메디테이션">
					<div class="card-body">
						<h6 class="card-title">포틱 메디테이션</h6>
						<p class="card-text card-text2">[루미너스]&nbsp;&nbsp;마력 +40<br /><small>(오닉스의 축복과 중첩 불가)</small></p>
						<input type="checkbox" value="photicMeditation" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/blessingOfTheOnyx.png" class="skill-img" alt="오닉스의 축복">
					<div class="card-body">
						<h6 class="card-title">오닉스의 축복</h6>
						<p class="card-text card-text2">[에반]<br />마력 +80</p>
						<input type="checkbox" value="blessingOfTheOnyx" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/hyperMonkeySpell.webp" class="skill-img" alt="하이퍼 몽키 스펠">
					<div class="card-body">
						<h6 class="card-title">하이퍼 몽키 스펠</h6>
						<p class="card-text card-text2">[캐논슈터]<br />올스탯 +61</p>
						<input type="checkbox" value="hyperMonkeySpell" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/chargeSpellAmplifier.webp" class="skill-img" alt="차지 스펠 앰플리케이션">
					<div class="card-body">
						<h6 class="card-title" style="font-size:13.5px;">차지 스펠 앰플리케이션</h6>
						<p class="card-text card-text2">[아크]&nbsp;&nbsp;공격력 +30, 데미지 +20%, 보스데미지 +30%, 방어율 무시 +20%</p>
						<input type="checkbox" value="chargeSpellAmplifier" name="partySkills" style="margin-top: 0px;" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/echoOfHero.png" class="skill-img" alt="영웅의 메아리">
					<div class="card-body">
						<h6 class="card-title">영웅의 메아리</h6>
						<p class="card-text card-text2">[전직업]&nbsp;&nbsp;공격력/마력 +4% <small>(= 익스클루시브 스펠)</small></p>
						<input type="checkbox" value="echoOfHero" name="partySkills" checked />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/callOfTheWild.webp" class="skill-img" alt="하울링">
					<div class="card-body">
						<h6 class="card-title">하울링</h6>
						<p class="card-text card-text2">[와일드헌터]<br />공격력/마력 +10%</p>
						<input type="checkbox" value="callOfTheWild" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/sharpEyes.webp" class="skill-img" alt="샤프아이즈">
					<div class="card-body">
						<h6 class="card-title">샤프 아이즈</h6>
						<p class="card-text card-text2">[일부 궁수]<br />크리데미지 +16%</p>
						<input type="checkbox" value="sharpEyes" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/combatOrders.webp" class="skill-img" alt="컴뱃 오더스">
					<div class="card-body">
						<h6 class="card-title">컴뱃 오더스</h6>
						<p class="card-text card-text2">[팔라딘]<br />직업마다 다르게 적용</p>
						<input type="checkbox" value="combatOrders" name="partySkills" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/skill/advancedBlessing.webp" class="skill-img" alt="어드밴스드 블레스">
					<div class="card-body">
						<h6 class="card-title">어드밴스드 블레스</h6>
						<p class="card-text card-text2">[비숍]&nbsp;&nbsp;공격력/마력 +50<br />보스데미지 +10%</p>
						<input type="checkbox" value="advancedBlessing" name="partySkills" />
					</div>
				</div>
			</div>
			
		<hr>

		<h4 class="information_msg">⑦&nbsp;&nbsp;기타</h4>
		<p>반짝이는 빨간별 물약과 고급 보스 킬러의 비약은 동시에 적용되지 않습니다. 둘 다 선택한 경우, 하나만 사용된 것으로 계산됩니다. 같은 이유로 반짝이는 파란별 물약과 고급 관통의 비약의 중복적용되지 않습니다.<br />반짝이는 물약류 중 하나와 고급 비약 중 하나를 선택해서 총 2개의 비약을 이미 선택한 경우, 비약은 최대 2개까지 적용이 가능하기 때문에 전설의 영웅 비약을 선택하더라도 사용한 것으로 적용되지 않습니다.</p>			
			<!-- 소비 아이템 -->
			<div class="row row-cols-auto">
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/sparklingRedStarPotion.webp" class="skill-img" alt="반짝이는 빨간별 물약">
					<div class="card-body">
						<h6 class="card-title" style="font-size:15px;">반짝이는 빨간별 물약</h6>
						<p class="card-text card-text2">보스데미지 +20%<br />&nbsp;</p>
						<input type="radio" value="sparklingRedStarPotion" name="sparklingPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/sparklingBlueStarPotion.webp" class="skill-img" alt="반짝이는 파란별 물약">
					<div class="card-body">
						<h6 class="card-title" style="font-size:15px;">반짝이는 파란별 물약</h6>
						<p class="card-text card-text2">방어율 무시 +20%<br />&nbsp;</p>
						<input type="radio" value="sparklingBlueStarPotion" name="sparklingPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/sparklingGoldStarPotion.webp" class="skill-img" alt="반짝이는 황금별 물약">
					<div class="card-body">
						<h6 class="card-title" style="font-size:15px;">반짝이는 황금별 물약</h6>
						<p class="card-text card-text2">공격력/마력 +20<br />&nbsp;</p>
						<input type="radio" value="sparklingGoldStarPotion" name="sparklingPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedBossRushBoostPotion.webp" class="skill-img" alt="고급 보스 킬러의 비약">
					<div class="card-body">
						<h6 class="card-title" style="font-size:14.5px;">고급 보스 킬러의 비약</h6>
						<p class="card-text card-text2">보스데미지 +20%<br />&nbsp;</p>
						<input type="radio" value="advancedBossRushBoostPotion" name="advancedPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedPenetratingBoostPotion.webp" class="skill-img" alt="고급 관통의 비약">
					<div class="card-body">
						<h6 class="card-title">고급 관통의 비약</h6>
						<p class="card-text card-text2">방어율 무시 +20%<br />&nbsp;</p>
						<input type="radio" value="advancedPenetratingBoostPotion" name="advancedPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedGreatHeroBoostPotion.webp" class="skill-img" alt="고급 대영웅의 비약">
					<div class="card-body">
						<h6 class="card-title">고급 대영웅의 비약</h6>
						<p class="card-text card-text2">데미지 +10%<br />&nbsp;</p>
						<input type="radio" value="advancedGreatHeroBoostPotion" name="advancedPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedGreatBlessingPotion.webp" class="skill-img" alt="고급 대축복의 비약">
					<div class="card-body">
						<h6 class="card-title">고급 대축복의 비약</h6>
						<p class="card-text card-text2">올스탯 +10%<br />&nbsp;</p>
						<input type="radio" value="advancedGreatBlessingPotion" name="advancedPotion" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/legendaryHeroPotion.webp" class="skill-img" alt="전설의 영웅 비약">
					<div class="card-body">
						<h6 class="card-title">전설의 영웅 비약</h6>
						<p class="card-text card-text2">공격력/마력 +30<br />&nbsp;</p>
						<input type="checkbox" value="legendaryHeroPotion" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedPotionX.webp" class="skill-img" alt="10단계 향상된 주스탯 물약">
					<div class="card-body">
						<h6 class="card-title">10단계 향상된 물약 (주스탯)</h6>
						<p class="card-text card-text2">주스탯 +30</p>
						<input type="checkbox" value="advancedPotionXForMainStat" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedPotionX.webp" class="skill-img" alt="10단계 향상된 부스탯 물약">
					<div class="card-body">
						<h6 class="card-title">10단계 향상된 물약 (부스탯)</h6>
						<p class="card-text card-text2">부스탯 +30</p>
						<input type="checkbox" value="advancedPotionXForSubStat" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/extremeRedPotion.webp" class="skill-img" alt="익스트림 레드" style="width: 120px;">
					<div class="card-body">
						<h6 class="card-title">익스트림 레드</h6>
						<p class="card-text card-text2">공격력 +30<br />&nbsp;</p>
						<input type="checkbox" value="extremeRedPotion" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/extremeBluePotion.webp" class="skill-img" alt="익스트림 블루" style="width: 120px;">
					<div class="card-body">
						<h6 class="card-title">익스트림 블루</h6>
						<p class="card-text card-text2">마력 +30<br />&nbsp;</p>
						<input type="checkbox" value="extremeBluePotion" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/unionsStrength.png" class="skill-img" alt="유니온의 힘">
					<div class="card-body">
						<h6 class="card-title">유니온의 힘</h6>
						<p class="card-text card-text2">공격력/마력 +30<br />&nbsp;</p>
						<input type="checkbox" value="unionsStrength" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/MVPSuperPowerBuff.png" class="skill-img" alt="MVP 슈퍼파워 버프">
					<div class="card-body">
						<h6 class="card-title">MVP 슈퍼파워 버프</h6>
						<p class="card-text card-text2">공격력/마력 +30<br />&nbsp;</p>
						<input type="checkbox" value="MVPSuperPowerBuff" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/guildBlessing.png" class="skill-img" alt="길드의 축복">
					<div class="card-body">
						<h6 class="card-title">길드의 축복</h6>
						<p class="card-text card-text2">공격력/마력 +20<br />&nbsp;</p>
						<input type="checkbox" value="guildBlessing" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/largerGuildBlessing.png" class="skill-img" alt="길드의 더 큰 축복">
					<div class="card-body">
						<h6 class="card-title">길드의 더 큰 축복</h6>
						<p class="card-text card-text2">공격력/마력 +30<br />&nbsp;</p>
						<input type="checkbox" value="largerGuildBlessing" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/masarayu'sGiftAtmosphericEffect.webp" class="skill-img" alt="마슈르의 선물 기상 효과">
					<div class="card-body">
						<h6 class="card-title" style="font-size:13.3px;">마슈르의 선물 기상 효과</h6>
						<p class="card-text card-text2">공격력/마력 +30<br /><small>(우르스 뿌리기)</small></p>
						<input type="checkbox" value="masarayusGiftAtmosphericEffect" name="usableItem" style="margin-top: 35px" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/atmosphericEffect.png" class="skill-img" alt="기상 효과">
					<div class="card-body">
						<h6 class="card-title">기상 효과</h6>
						<p class="card-text card-text2">공격력/마력 +30<br /><small>생일 축하해, 붕어빵 뿌리기 등</small></p>
						<input type="checkbox" value="atmosphericEffect" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/throneOfMasters.webp" class="skill-img" alt="명예의 상징">
					<div class="card-body">
						<h6 class="card-title">명예의 상징</h6>
						<p class="card-text card-text2">공격력/마력 +40<br /><small>레벨 250 의자 인기도 버프</small></p>
						<input type="checkbox" value="blessingOfThe250" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/blessingOfThe275.png" class="skill-img" alt="찬란한 명예의 상징">
					<div class="card-body">
						<h6 class="card-title">찬란한 명예의 상징</h6>
						<p class="card-text card-text2">공격력/마력 +50<br /><small>레벨 275 의자 인기도 버프</small></p>
						<input type="checkbox" value="blessingOfThe275" name="usableItem" />
					</div>
				</div>
				<div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/soulWeapon.gif" class="skill-img" alt="소울 웨폰">
					<div class="card-body">
						<h6 class="card-title">소울 게이지 충전</h6>
						<p class="card-text card-text2">공격력/마력 +20<br /><small>사망 시 효과 사라짐</small></p>
						<input type="checkbox" value="soulWeapon" name="usableItem" />
					</div>
				</div>
				<!--  <div class="card" style="width: 12rem; height: 20rem;">
					<img src="StatCalculator_img/usableItem/advancedWeaponTempering.png" class="skill-img" alt="고급 무기 제련">
					<div class="card-body">
						<h6 class="card-title">고급 무기 제련</h6>
						<p class="card-text">크리데미지 +5%<br />&nbsp;</p>
						<input type="checkbox" value="advancedWeaponTempering" name="usableItem" />
					</div>
				</div>-->

			</div>

		<div style="float:right;">
			<input type="reset" value="초기화" class="last-btn" /><input type="submit" value="제출" class="last-btn" />
		</div>
	</form>

	<hr class="featurette-divider">
	
	<!-- Footer 불러오기 -->
	<jsp:include page="../Snippets/Footer.jsp" />
	
	<!-- Script 불러오기 -->
	<jsp:include page="../Snippets/Script.jsp" />
</body>

</html>
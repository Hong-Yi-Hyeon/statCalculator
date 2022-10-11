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
<title>스탯 효율 계산기 결과</title>

<!-- css 링크 가져오기 -->
<jsp:include page="../Snippets/Css.jsp" />
<link href="StatCalculator.css" rel="stylesheet">
<link href="StatCalculatorResult.css" rel="stylesheet">
</head>

<body>
	<!-- Header 불러오기 -->
	<jsp:include page="../Snippets/Header.jsp" />
	
	<form class="StatCalculatorForm" action="StatCalculatorProcess.jsp" method="post" name="ShadeForm" style="padding: 10px;">
		
		<h2 style="color:orangered; font-weight:bold; line-height:200%;">스탯계산기 결과 분석&nbsp;<span style="color: orange; font-size: 16px;">StatCalculator Result Analysis</span></h2>
		
		<div class="table-title">
			<h5 class="information_msg">ⓐ 사용자 정보 확인</h5>
		</div>
		<table>
			<tr>
				<td>직업 : ${job}</td>
				<td>직업 상수 : ${jobConstant}</td>
				<td>무기 상수 : ${weaponConstant}</td>
				<td>레벨 : ${level}</td>
			</tr>
			<tr>
				<td>주스탯 <small style="font-size:10px;">(메용 o)</small> : ${mainStatUsedMW}</td>
				<td>주스탯 <small style="font-size:10px;">(메용 x)</small> : ${mainStatDisusedMW}</td>				
				<td><small style="font-size:10px;">(아이템으로 증가한)</small> 주스탯 % : ${mainStatPercent - 100}%</td>
				<td>부스탯 : ${subStat}</td>		
			</tr>
			<tr>
				<td>공격력/마력 : ${att}</td>
				<td>공격력/마력 % : ${attPercent}%</td>
				<td>방어율 무시 : ${ignoreDefTxt}%</td>
			</tr>
			<tr>
				<td>데미지 : ${damage}%</td>
				<td>보스데미지 : ${bossDamage}%</td>
				<td>크리데미지 : ${critDamage}%</td>
				<td>최종데미지 : ${finalDamage}%</td>
			</tr>
		</table>
		
		<hr>
		
		<div class="table-title">
			<h5 class="information_msg">ⓑ 스탯 효율 계산 결과</h5>
		</div>
		<table>
			<tr>
				<td style="width: 160px;">주스탯 1%</td>
				<td>: &nbsp;<span style="font-weight: bold; color: red;">주스탯 ${statPerMainStatPercentTxt}</span> &nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-weight: bold; color: red;">공격력 ${attPerMainStatPercentTxt}</span></td>
			</tr>
			<tr>
				<td style="width: 160px;">공격력 1</td>
				<td>: &nbsp;<span style="font-weight: bold; color: red;">주스탯 ${statPerAttTxt}</span> &nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp; 주스탯 ${mainStatPercentPerAttTxt}%</td>
			</tr>
<!-- 
			<tr>
				<td>(보스)데미지 1%</td>
				<td>: &nbsp;주스탯 ${statPerDamageTxt} &nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp; 주스탯 ${statPercentPerDamageTxt}</td>
			</tr>
-->			
			<tr>
				<td style="width: 160px;">크리티컬 데미지 1%</td>
				<td>: &nbsp;주스탯 ${statPerCritDamageTxt} &nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-weight: bold; color: red;">주스탯 ${mainStatPercentPerCritDamageTxt}%</span></td>
			</tr>			
		</table>
		
		<hr>
		
		<div class="table-title">
			<h5 class="information_msg">ⓒ 잠재능력 효율 계산 결과</h5>
			<p>자주 사용하는 잠재능력/에디셔널 잠재능력의 옵션 중 일부의 효율을 계산하여 보기 쉽게 정리하였습니다.</p> 
		</div>
		
		<table>
			<tr>
				<td style="width: 500px;"><span class="epic">[에픽] </span>주스탯 +4% / <span class="unique">[유니크] </span>+5%</td>
				<td class="td-potential">: &nbsp;공격력 ${attPerMainStatPercent4Txt} / ${attPerMainStatPercent5Txt}</td>
			</tr>
			<tr>
				<td><span class="legendary">[레전더리] </span>주스탯 +16 / +18</td>
				<td class="td-potential">: &nbsp;주스탯 ${mainStatPercentPerMainStat16Txt}% / ${mainStatPercentPerMainStat18Txt}%</td>
			</tr>
			<tr>
				<td><span class="rare">[레어] </span>공격력 +10 / <span class="epic">[에픽] </span>+11 / <span class="unique">[유니크] </span>+12</td>
				<td class="td-potential">: &nbsp;주스탯 ${mainStatPercentPerAtt10Txt}% / ${mainStatPercentPerAtt11Txt}% / ${mainStatPercentPerAtt12Txt}%</td>
			</tr>
			<tr>
				<td><span class="legendary">[레전더리] </span>크리티컬 데미지 +3% / +8%</td>
				<td class="td-potential">: &nbsp;주스탯 ${mainStatPercentPerCritDamage3Txt}% / ${mainStatPercentPerCritDamage8Txt}%</td>
			</tr>
			<tr>
				<td><span class="legendary">[레전더리] </span>캐릭터 기준 10레벨 당 주스탯 +1 / +2</td>
				<td class="td-potential">: &nbsp;주스탯 ${mainStatPercentPerStatPerCharacterLevelsTxt}% / ${mainStatPercentPerStatPerCharacterLevels2Txt}%</td>
			</tr>
			<tr>
				<td><span class="rare">[레어] </span>공격력 3% / <span class="epic">[에픽] </span>6% / <span class="unique">[유니크] </span>9% / 12%</td>
				<td class="td-potential">: &nbsp;보스데미지 ${bossDamagePerAttPercent3Txt}% / ${bossDamagePerAttPercent6Txt}% / ${bossDamagePerAttPercent9Txt}% / ${bossDamagePerAttPercent12Txt}%</td>
			</tr>
			<tr>
				<td><span class="unique">[유니크] </span>보스데미지 20% / 30% / <span class="legendary">[레전더리] </span>35% / 40%</td>
				<td class="td-potential">: &nbsp;공격력 ${attPercentPerBossDamage20Txt}% / ${attPercentPerBossDamage30Txt}% / ${attPercentPerBossDamage35Txt}% / ${attPercentPerBossDamage40Txt}%</td>
			</tr>
			<tr>
				<td><span class="epic">[에픽] </span>방어율 무시 15% / <span class="unique">[유니크] </span>30% / <span class="legendary">[레전더리] </span>35% / 40%</td>
				<td class="td-potential">: &nbsp;보스데미지 ${bossDamagePerIgnoreDef15Txt}% / ${bossDamagePerIgnoreDef30Txt}% / ${bossDamagePerIgnoreDef35Txt}% / ${bossDamagePerIgnoreDef40Txt}%</td>
			</tr>
			<tr>
				<td><span class="epic">[에픽] </span>방어율 무시 15% / <span class="unique">[유니크] </span>30% / <span class="legendary">[레전더리] </span>35% / 40%</td>
				<td class="td-potential">: &nbsp;공격력 ${attPercentPerIgnoreDef15Txt}% / ${attPercentPerIgnoreDef30Txt}% / ${attPercentPerIgnoreDef35Txt}% / ${attPercentPerIgnoreDef40Txt}%</td>
			</tr>
		</table>
		
		<hr>
		
		<div class="table-title">
			<h5 class="information_msg">ⓓ 링크 스킬 효율 계산 결과</h5>
			<p>각 링크스킬은 사용하지 않았을 때보다 사용했을 때 보스에게 적용되는 데미지가 몇 % 증가하는지로 효율을 측정했습니다.<br /> 
				<small style="color: grey; font-size: 10px; line-height: 120%;">엔젤릭버스터의 링크스킬, '소울컨트랙트'는 극딜 메타에 반드시 채용되는 스킬이기 때문에 효율 계산에서 제외했습니다.</small>
			</p> 
		</div>
		
		<table>
			<tr>
				<td class="td-link"><img src="./StatCalculator_img/skill/empiricalKnowledge.webp" alt="임피리컬 널리지" />&nbsp;&nbsp;&nbsp;임피리컬 널리지 : ${empiricalKnowledgeEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/thief'sCunning.webp" alt="시프 커닝" />&nbsp;&nbsp;&nbsp;시프 커닝 : ${thiefsCunningEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/pirateBlessing.webp" alt="파이렛 블레스" />&nbsp;&nbsp;&nbsp;파이렛 블레스 : ${pirateBlessingEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/cygnusBlessing.png" alt="시그너스 블레스" />&nbsp;&nbsp;&nbsp;시그너스 블레스 : ${cygnusBlessingEfficiencyTxt}%</td>
			</tr>
			<tr>
				<td class="td-link"><img src="./StatCalculator_img/skill/wildRage.png" alt="와일드 레이지" />&nbsp;&nbsp;&nbsp;와일드 레이지 : ${wildRageEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/furyUnleashed.png" alt="데몬스 퓨리" />&nbsp;&nbsp;&nbsp;데몬스 퓨리 : ${furyUnleashedEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/hybridLogic.png" alt="하이브리드 로직" />&nbsp;&nbsp;&nbsp;하이브리드 로직 : ${hybridLogicEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/lightWash.png" alt="퍼미에이트" />&nbsp;&nbsp;&nbsp;퍼미에이트 : ${lightWashEfficiencyTxt}%</td>
			</tr>
			<tr>
				<td class="td-link"><img src="./StatCalculator_img/skill/timeToPrepare.png" alt="프라이어 프리퍼레이션" />&nbsp;&nbsp;&nbsp;프라이어 프리퍼레이션 : ${timeToPrepareEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/unfairAdvantage.png" alt="인텐시브 어썰트" />&nbsp;&nbsp;&nbsp;인텐시브 어썰트 : ${unfairAdvantageEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/nobleFire.png" alt="노블레스" />&nbsp;&nbsp;&nbsp;노블레스<small>(1인)</small> : ${nobleFireEfficiency_soloTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/nobleFire.png" alt="노블레스" />&nbsp;&nbsp;&nbsp;노블레스<small>(6인)</small> : ${nobleFireEfficiency_partyTxt}%</td>
			</tr>
			<tr>
				<td class="td-link"><img src="./StatCalculator_img/skill/tideOfBattle.png" alt="전투의 흐름" />&nbsp;&nbsp;&nbsp;전투의 흐름 : ${solusEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/solus.png" alt="무아" />&nbsp;&nbsp;&nbsp;무아 : ${solusEfficiencyTxt}%</td>
				<td class="td-link"><img src="./StatCalculator_img/skill/judgement.png" alt="판단" />&nbsp;&nbsp;&nbsp;판단 : ${judgementEfficiencyTxt}%</td>
			</tr>
		</table>
		
		<hr>
		
		<div class="table-title">
			<h5 class="information_msg">ⓔ 몬스터라이프 효율 계산 결과</h5>
			<p>몬스터 라이프에 존재하는 다양한 몬스터의 수치를 보기쉽게 주스탯으로 환산하였습니다.</p> 
		</div>

		<div class="row row-cols-auto">
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/mugong'sShadow.png" class="card-img-top" alt="무공의 분신 / 에피네아" style="width: 150px;">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">무공의 분신 & 에피네아</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 각각 공격력 +3 / 마력 +3</span><br />
						<b>스탯 효율 : ${statPerAtt3Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteLuminous(Dark).png" class="card-img-top" alt="쁘띠 루미너스(어둠) / 미르">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 루미너스(어둠) & 미르</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 공격력/마력 +5</span><br />
						<b>스탯 효율 : ${statPerAtt5Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/shadowOfDarkWizard.png" class="card-img-top" alt="검은 마법사의 그림자">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">검은 마법사의 그림자</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 공격력/마력 +6</span><br />
						<b>스탯 효율 : ${statPerAtt6Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteLuminous(Equilibrium).png" class="card-img-top" alt="쁘띠 루미너스(이퀄리브리엄)" style="width: 180px;">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 루미너스(이퀄리브리엄)</span><br />
					</p>
					<p class="card-text">
						<span>효과 : <small>레벨 20당</small> 공격력 +1</span><br />
						<b>스탯 효율 : ${petiteLuminousEquilibriumEfficiencyTxt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteHilla.png" class="card-img-top" alt="쁘띠 힐라" style="width: 120px;">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 힐라</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 크리티컬 데미지 +2%</span><br />
						<b>스탯 효율 : ${statPerCritDamage2Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/blackViking.png" class="card-img-top" alt="검은 바이킹">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">검은 바이킹</span><br />
					</p>
					<p class="card-text">
						<span>효과 : DEX +5, 데미지 +2%</span><br />
						<b>스탯 효율 : ${blackVikingEfficiencyTxt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/pinkBean.png" class="card-img-top" alt="핑크빈" style="width: 150px;">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">핑크빈</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 데미지 +2%</span><br />
						<b>스탯 효율 : ${statPerDamage2Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteCygnus.png" class="card-img-top" alt="쁘띠 시그너스 / 바이킹 군단">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 시그너스 & 바이킹 군단</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 데미지 +3%</span><br />
						<b>스탯 효율 : ${statPerDamage3Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/scarecrow.png" class="card-img-top" alt="허수아비">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">허수아비</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 데미지 +4%</span><br />
						<b>스탯 효율 : ${statPerDamage4Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteVonLeon.png" class="card-img-top" alt="쁘띠 반레온">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 반레온</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 보스 데미지 +5%</span><br />
						<b>스탯 효율 : ${statPerDamage5Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteMoonbeam.png" class="card-img-top" alt="쁘띠 랑">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 랑</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 보스 데미지 +8%</span><br />
						<b>스탯 효율 : ${statPerDamage8Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/petiteMagnus.png" class="card-img-top" alt="쁘띠 매그너스 / 라피스">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">쁘띠 매그너스 & 라피스</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 방어율 무시 +5%</span><br />
						<b>스탯 효율 : ${statPerIgnoreDef5Txt}</b>
					</p>
				</div>
			</div>
			<div class="card" style="width: 13.5rem;">
				<img src="./StatCalculator_img/monsterLife/tinWoodman.png" class="card-img-top" alt="양철 나무꾼" style="width: 170px">
				<div class="card-body">
					<p class="card-text card-title">
						<span class="card-title">양철 나무꾼</span><br />
					</p>
					<p class="card-text">
						<span>효과 : 방어율 무시 +6%</span><br />
						<b>스탯 효율 : ${statPerIgnoreDef6Txt}</b>
					</p>
				</div>
			</div>
		</div>
		
		<hr>
		
		<div class="table-title">
			<h5 class="information_msg">ⓕ 기타 정보</h5>
		</div>
		<table style="margin-bottom: 0px;">
			<tr>
				<td style="width: 600px;">주스탯 1%가 증가할 때마다 표기 주스탯이 <b>'${increasingMainStat}'</b>만큼 증가합니다.</td>
			</tr>
			<tr>
				<td style="width: 600px;">현재 방어율 300% 보스에게 적용되는 최종데미지는 <b>'${finalDamageForBoss}%'</b>입니다.</td>
			</tr>
			<tr>
				<td style="width: 600px;">${AttPercentVSbossDamage}</td>
			</tr>
		</table>
		
	</form>

	<% session.invalidate(); %>
	
	<hr>
	
	<!-- Footer 불러오기 -->
	<jsp:include page="../Snippets/Footer.jsp" />
	
	<!-- Script 불러오기 -->
	<jsp:include page="../Snippets/Script.jsp" />
</body>
</html>
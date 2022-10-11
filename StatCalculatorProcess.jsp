<%@ page import="job.JobDTO" %>
<%@ page import="job.JobDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
/* 사용자 입력 정보 */
String job = request.getParameter("job");
int level = Integer.parseInt(request.getParameter("level"));
int statAtt = Integer.parseInt(request.getParameter("statAtt"));
int mainStatUsedMW = Integer.parseInt(request.getParameter("mainStatUsedMW"));
int mainStatDisusedMW = Integer.parseInt(request.getParameter("mainStatDisusedMW"));
int subStat = Integer.parseInt(request.getParameter("subStat"));
int unionStat = Integer.parseInt(request.getParameter("unionStat"));
int hyperStat = Integer.parseInt(request.getParameter("hyperStat"));
int abilityStat = Integer.parseInt(request.getParameter("abilityStat"));
int arcaneStat = Integer.parseInt(request.getParameter("arcaneStat"));
int authenticStat = Integer.parseInt(request.getParameter("authenticStat"));
int attPercent = Integer.parseInt(request.getParameter("attPercent"));
int damage = Integer.parseInt(request.getParameter("damage"));
int bossDamage = Integer.parseInt(request.getParameter("bossDamage"));
double critDamage = Double.parseDouble(request.getParameter("critDamage"));
int afflictedByAbnormalStatusesDamage = Integer.parseInt(request.getParameter("afflictedByAbnormalStatusesDamage"));
damage += afflictedByAbnormalStatusesDamage;
double ignoreDef = Double.parseDouble(request.getParameter("ignoreDef"));

int bossSlayers = Integer.parseInt(request.getParameter("bossSlayers"));
int undeterred = Integer.parseInt(request.getParameter("undeterred"));
int forTheGuild = Integer.parseInt(request.getParameter("forTheGuild"));
int bigHit = Integer.parseInt(request.getParameter("bigHit"));

String[] linkSkills = request.getParameterValues("linkSkills");
String[] decentSkills = request.getParameterValues("decentSkills");
String[] partySkills = request.getParameterValues("partySkills");

String sparklingPotion = request.getParameter("sparklingPotion");
String advancedPotion = request.getParameter("advancedPotion");
String[] usableItem = request.getParameterValues("usableItem");

/* web.xml에서 가져온 DB 연결 정보 */
String mySQLDriver = application.getInitParameter("MySQLDriver");
String mySQLURL = application.getInitParameter("MySQLURL");
String mySQLId = application.getInitParameter("MySQLId");
String mySQLPw = application.getInitParameter("MySQLPw");

/* DAO를 통해 DTO 획득 */
JobDAO dao = new JobDAO(mySQLDriver, mySQLURL, mySQLId, mySQLPw);
JobDTO dto = dao.getJobDTO(job);

/* 사용자 입력 정보(job)에 따른 고정 변수 추출 */
double weaponConstant = dto.getWeaponConstant();
double jobConstant = dto.getJobConstant();
double finalDamage = dto.getFinalDamage();

/* 사용자 입력 정보를 토대로 필요한 정보 계산 */
int pureMainStat = level * 5 + 18;
int increasedStatBecauseOfMW = (int) Math.round(pureMainStat * 0.15);
int fixedMainStat = unionStat + hyperStat + abilityStat + arcaneStat + authenticStat;
double mainStatPercent = Math.round((double) (mainStatUsedMW - mainStatDisusedMW) / increasedStatBecauseOfMW * 100);
int variedMainStat = (int) Math.round((mainStatDisusedMW - fixedMainStat) / Math.round(mainStatPercent / 100));
int att = (int) Math.round(statAtt / (double) (mainStatDisusedMW * 4 + subStat) / 0.01 / (1 + ((double) attPercent / 100)) / (1 + ((double) damage / 100)) / (1 + ((double) finalDamage / 100)) / weaponConstant / jobConstant);

mainStatPercent = Math.round(mainStatPercent);
int mainStatPercentInt = (int) Math.round(mainStatPercent);

/* 길드스킬 반영 */
try {
	bossDamage += bossSlayers;
	ignoreDef = ignoreDef + (100 - ignoreDef) * ((double) undeterred / 100);
	damage += forTheGuild;
	critDamage += bigHit;
} catch (Exception e) {
	System.out.println("길드 스킬 미적용");
}

/* 링크스킬 반영 */
boolean empiricalKnowledgeFlag = false;
boolean thiefsCunningFlag = false;
boolean pirateBlessingFlag = false;
boolean cygnusBlessingFlag = false;
boolean wildRageFlag = false;
boolean furyUnleashedFlag = false;
boolean hybridLogicFlag = false;
boolean lightWashFlag = false;
boolean timeToPrepareFlag = false;
boolean unfairAdvantageFlag = false;
boolean nobleFireFlag = false;
boolean tideOfBattleFlag = false;
boolean solusFlag = false;
boolean judgementFlag = false;

try {
	for (int i = 0; i < linkSkills.length; i++) {
		if (linkSkills[i].equals("empiricalKnowledge")) {
			damage = damage + 9;
			ignoreDef = ignoreDef + (100 - ignoreDef) * 0.09;
			empiricalKnowledgeFlag = true;
		}
		if (linkSkills[i].equals("thiefsCunning")) {
			damage += 9;
			thiefsCunningFlag = true;
		}
		if (linkSkills[i].equals("pirateBlessing")) {
			pirateBlessingFlag = true;
		}
		if (linkSkills[i].equals("cygnusBlessing")) {
			cygnusBlessingFlag = true;
		}
		if (linkSkills[i].equals("wildRage")) {
			wildRageFlag = true;
		}
		if (linkSkills[i].equals("furyUnleashed")) {
			furyUnleashedFlag = true;
		}
		if (linkSkills[i].equals("hybridLogic")) {
			hybridLogicFlag = true;
		}
		if (linkSkills[i].equals("lightWash")) {
			lightWashFlag = true;
		}
		if (linkSkills[i].equals("timeToPrepare")) {
			damage += 7;
			timeToPrepareFlag = true;
		}
		if (linkSkills[i].equals("unfairAdvantage")) {
			damage += 12;
			unfairAdvantageFlag = true;
		}
		/*
		if (linkSkills[i].equals("termsAndConditions")) {
		}
		*/
		if (linkSkills[i].equals("nobleFire")) {
			nobleFireFlag = true;
		}
		if (linkSkills[i].equals("tideOfBattle")) {
			damage += 10;
			tideOfBattleFlag = true;
		}
		if (linkSkills[i].equals("solus")) {
			damage += 10;
			solusFlag = true;
		}
		if (linkSkills[i].equals("judgement")) {
			judgementFlag = true;
		}
	}
} catch (Exception e) {
	System.out.println("링크스킬 미적용");
}

/* 파티 스킬 반영 */
boolean sharpEyesFlag = true;
boolean combatOrdersFlag = true;
boolean advancedBlessingFlag = true;
boolean magiciansBuffFlag = true; // 포틱 메디테이션이랑 오닉스의 축복 중첩 안 되게 설정

try {
	for (int i = 0; i < partySkills.length; i++) {
		if (partySkills[i].equals("spiritBlade")) {
			if (job.equals("hero") || job.equals("paladin") || job.equals("darkKnight") || job.equals("mihile") || job.equals("dawnWarrior") || job.equals("demonAvenger") || job.equals("demonSlayer") || job.equals("blaster") || job.equals("aran") || job.equals("kaiser") || job.equals("adele") || job.equals("zero") || job.equals("bowmaster") || job.equals("marksman") || job.equals("pathfinder") || job.equals("windArcher") || job.equals("wildHunter") || job.equals("mercedes") || job.equals("kain") || job.equals("nightLords") || job.equals("shadowers") || job.equals("dualBlade") || job.equals("nightWalker") || job.equals("xenon") || job.equals("phantom") || job.equals("cadena") || job.equals("hoyoung") || job.equals("buccaneer") || job.equals("corsair") || job.equals("cannoneer") || job.equals("thunderBreaker") || job.equals("mechanic") || job.equals("shade") || job.equals("angelicBuster") || job.equals("ark")) {
				att += 30;
			}
		}
		if (partySkills[i].equals("beholdersBuff")) {
			if (job.equals("darkKnight")) {
				att = att + 70;
			} else {
				att = att + 35;
			}
		}
		if (partySkills[i].equals("encourage")) {
			if (job.equals("hero") || job.equals("paladin") || job.equals("darkKnight") || job.equals("mihile") || job.equals("dawnWarrior") || job.equals("demonAvenger") || job.equals("demonSlayer") || job.equals("blaster") || job.equals("aran") || job.equals("kaiser") || job.equals("adele") || job.equals("zero") || job.equals("bowmaster") || job.equals("marksman") || job.equals("pathfinder") || job.equals("windArcher") || job.equals("wildHunter") || job.equals("mercedes") || job.equals("kain") || job.equals("nightLords") || job.equals("shadowers") || job.equals("dualBlade") || job.equals("nightWalker") || job.equals("xenon") || job.equals("phantom") || job.equals("cadena") || job.equals("hoyoung") || job.equals("buccaneer") || job.equals("corsair") || job.equals("cannoneer") || job.equals("thunderBreaker") || job.equals("mechanic") || job.equals("shade") || job.equals("angelicBuster") || job.equals("ark")) {
				att += 30;
			}
		}
		if (partySkills[i].equals("mahaBlessing")) {
			att += 30;
		}
		if (partySkills[i] == "meditation") {
			if (job.equals("magician(fire,poison)") || job.equals("magician(ice,lightning)") || job.equals("bishop") || job.equals("blazeWizard") || job.equals("battleMage") || job.equals("evan") || job.equals("luminous") || job.equals("illium") || job.equals("lara") || job.equals("kinesis")) {
				att += 30;
			}
		}
		if (partySkills[i].equals("photicMeditation")) {
			if (job.equals("magician(fire,poison)") || job.equals("magician(ice,lightning)") || job.equals("bishop") || job.equals("blazeWizard") || job.equals("battleMage") || job.equals("evan") || job.equals("luminous") || job.equals("illium") || job.equals("lara") || job.equals("kinesis")) {
				att += 40;
				magiciansBuffFlag = false;
			}
		}
		if (partySkills[i].equals("blessingOfTheOnyx")) {
			if (job.equals("magician(fire,poison)") || job.equals("magician(ice,lightning)") || job.equals("bishop") || job.equals("blazeWizard") || job.equals("battleMage") || job.equals("evan") || job.equals("luminous") || job.equals("illium") || job.equals("lara") || job.equals("kinesis")) {
				if (magiciansBuffFlag) {
					att += 80;
				} else {
					att += 40;
				}
			}
		}
		if (partySkills[i].equals("hyperMonkeySpell")) {
			mainStatDisusedMW += 61;
			subStat += 61;
		}
		if (partySkills[i].equals("chargeSpellAmplifier")) {
			if (job.equals("ark")) {
				att += 60;
				damage += 40;
				bossDamage += 60;
				double temp = ignoreDef + (100 - ignoreDef) * 0.2;
				ignoreDef = temp + (100 - temp) * 0.2;
			} else if (job.equals("hero") || job.equals("paladin") || job.equals("darkKnight") || job.equals("mihile") || job.equals("dawnWarrior") || job.equals("demonAvenger") || job.equals("demonSlayer") || job.equals("blaster") || job.equals("aran") || job.equals("kaiser") || job.equals("adele") || job.equals("zero") || job.equals("bowmaster") || job.equals("marksman") || job.equals("pathfinder") || job.equals("windArcher") || job.equals("wildHunter") || job.equals("mercedes") || job.equals("kain") || job.equals("nightLords") || job.equals("shadowers") || job.equals("dualBlade") || job.equals("nightWalker") || job.equals("xenon") || job.equals("phantom") || job.equals("cadena") || job.equals("hoyoung") || job.equals("buccaneer") || job.equals("corsair") || job.equals("cannoneer") || job.equals("thunderBreaker") || job.equals("mechanic") || job.equals("shade") || job.equals("angelicBuster")) {
				att += 30;
				damage += 20;
				bossDamage += 30;
				ignoreDef = ignoreDef + (100 - ignoreDef) * 0.2;
			} else {
				damage += 20;
				bossDamage += 30;
				ignoreDef = ignoreDef + (100 - ignoreDef) * 0.2;
			}
		}
		if (partySkills[i].equals("echoOfHero")) {
			attPercent += 4;
		}
		if (partySkills[i].equals("callOfTheWild")) {
			attPercent += 10;
		}
		if (partySkills[i].equals("sharpEyes")) {
			critDamage += 16;
			sharpEyesFlag = false;
		}
		if (partySkills[i].equals("combatOrders")) {
			if (job.equals("hero")) {

			} else if (job.equals("paladin")) {

			} else if (job.equals("darkKnight")) {

			} else if (job.equals("mihile")) {

			} else if (job.equals("dawnWarrior")) {

			} else if (job.equals("demonAvenger")) {

			} else if (job.equals("demonSlayer")) {

			} else if (job.equals("blaster")) {

			} else if (job.equals("aran")) {

			} else if (job.equals("kaiser")) {

			} else if (job.equals("adele")) {

			} else if (job.equals("zero")) {

			} else if (job.equals("magician(fire,poison)")) {

			} else if (job.equals("magician(ice,lightning)")) {

			} else if (job.equals("bishop")) {

			} else if (job.equals("blazeWizard")) {

			} else if (job.equals("battleMage")) {

			} else if (job.equals("evan")) {

			} else if (job.equals("luminous")) {

			} else if (job.equals("illium")) {

			} else if (job.equals("lara")) {

			} else if (job.equals("kinesis")) {

			} else if (job.equals("bowmaster")) {

			} else if (job.equals("marksman")) {

			} else if (job.equals("pathfinder")) {

			} else if (job.equals("windArcher")) {

			} else if (job.equals("wildHunter")) {

			} else if (job.equals("mercedes")) {

			} else if (job.equals("kain")) {

			} else if (job.equals("nightLords")) {

			} else if (job.equals("shadowers")) {

			} else if (job.equals("dualBlade")) {

			} else if (job.equals("nightWalker")) {

			} else if (job.equals("xenon")) {

			} else if (job.equals("phantom")) {

			} else if (job.equals("cadena")) {

			} else if (job.equals("hoyoung")) {

			} else if (job.equals("buccaneer")) {

			} else if (job.equals("corsair")) {

			} else if (job.equals("cannoneer")) {

			} else if (job.equals("thunderBreaker")) {

			} else if (job.equals("mechanic")) {

			} else if (job.equals("shade")) {

			} else if (job.equals("angelicBuster")) {

			} else if (job.equals("ark")) {

			}
			combatOrdersFlag = false;
		}
		if (partySkills[i].equals("advancedBlessing")) {
			att += 50;
			bossDamage += 10;
			advancedBlessingFlag = false;
		}
	}
} catch (Exception e) {
	System.out.println("파티스킬 미적용");
}

/* 쓸만한 스킬 반영 */
try {
	for (int i = 0; i < decentSkills.length; i++) {
		if (decentSkills[i].equals("decentSharpEyes")) {
			if (sharpEyesFlag) {
				critDamage += 8;
			}
		}
		if (decentSkills[i].equals("decentCombatOrders")) {
			if (combatOrdersFlag) {
				if (job.equals("hero")) {

				} else if (job.equals("paladin")) {

				} else if (job.equals("darkKnight")) {

				} else if (job.equals("mihile")) {

				} else if (job.equals("dawnWarrior")) {

				} else if (job.equals("demonAvenger")) {

				} else if (job.equals("demonSlayer")) {

				} else if (job.equals("blaster")) {

				} else if (job.equals("aran")) {

				} else if (job.equals("kaiser")) {

				} else if (job.equals("adele")) {

				} else if (job.equals("zero")) {

				} else if (job.equals("magician(fire,poison)")) {

				} else if (job.equals("magician(ice,lightning)")) {

				} else if (job.equals("bishop")) {

				} else if (job.equals("blazeWizard")) {

				} else if (job.equals("battleMage")) {

				} else if (job.equals("evan")) {

				} else if (job.equals("luminous")) {

				} else if (job.equals("illium")) {

				} else if (job.equals("lara")) {

				} else if (job.equals("kinesis")) {

				} else if (job.equals("bowmaster")) {

				} else if (job.equals("marksman")) {

				} else if (job.equals("pathfinder")) {

				} else if (job.equals("windArcher")) {

				} else if (job.equals("wildHunter")) {

				} else if (job.equals("mercedes")) {

				} else if (job.equals("kain")) {

				} else if (job.equals("nightLords")) {

				} else if (job.equals("shadowers")) {

				} else if (job.equals("dualBlade")) {
	
				} else if (job.equals("nightWalker")) {

				} else if (job.equals("xenon")) {

				} else if (job.equals("phantom")) {

				} else if (job.equals("cadena")) {

				} else if (job.equals("hoyoung")) {

				} else if (job.equals("buccaneer")) {

				} else if (job.equals("corsair")) {

				} else if (job.equals("cannoneer")) {

				} else if (job.equals("thunderBreaker")) {

				} else if (job.equals("mechanic")) {

				} else if (job.equals("shade")) {

				} else if (job.equals("angelicBuster")) {

				} else if (job.equals("ark")) {

				}
			}
		}
		if (decentSkills[i].equals("decentAdvancedBlessing")) {
			if (advancedBlessingFlag) {
				att += 20;
			}
		}
	}
} catch (Exception e) {
	System.out.println("쓸만한 스킬 미적용");
}

/* 포션 반영 */
int potionCnt = 0;
boolean bossDamagePotionFlag = true;
boolean ignoreDefPotionFlag = true;
boolean guildBlessingFlag = true; // 길드의 축복이랑 길드의 더 큰 축복 중첩 안 되게 설정
boolean blessingOfTheLevelFlag = true; // 250 의자와 275 의자 중첩 안 되게 설정

try {
	if (sparklingPotion.equals("sparklingRedStarPotion")) {
		bossDamage += 20;
		potionCnt++;
		bossDamagePotionFlag = false;
	} else if (sparklingPotion.equals("sparklingBlueStarPotion")) {
		ignoreDef = ignoreDef + (100 - ignoreDef) * 0.2;
		potionCnt++;
		ignoreDefPotionFlag = false;
	} else if (sparklingPotion.equals("sparklingGoldStarPotion")) {
		att += 30;
		potionCnt++;
	}
} catch (Exception e) {
	System.out.println("반짝이는 물약류 미사용");
}

try {
	if (advancedPotion.equals("advancedBossRushBoostPotion")) {
		if (bossDamagePotionFlag) {
			bossDamage += 20;
			potionCnt++;
		}
	} else if (advancedPotion.equals("advancedPenetratingBoostPotion")) {
		if (ignoreDefPotionFlag) {
			ignoreDef = ignoreDef + (100 - ignoreDef) * 0.2;
			potionCnt++;
		}
	} else if (advancedPotion.equals("advancedGreatHeroBoostPotion")) {
		damage += 10;
		potionCnt++;
	} else if (advancedPotion.equals("advancedGreatBlessingPotion")) {
		mainStatPercent = mainStatPercent + 10;
		potionCnt++;
	}
} catch (Exception e) {
	System.out.println("고급 비약류 미사용");
}

try {
	for (int i = 0; i < usableItem.length; i++) {
		if (usableItem[i].equals("legendaryHeroPotion")) {
			if (potionCnt < 2) {
				att += 30;
			}
		}
		if (usableItem[i].equals("advancedPotionXForMainStat")) {
			variedMainStat += 30;
		}
		if (usableItem[i].equals("advancedPotionXForSubStat")) {
			subStat += 30;
		}
		if (usableItem[i].equals("extremeRedPotion")) {
			if (job.equals("hero") || job.equals("paladin") || job.equals("darkKnight") || job.equals("mihile") || job.equals("dawnWarrior") || job.equals("demonAvenger") || job.equals("demonSlayer") || job.equals("blaster") || job.equals("aran") || job.equals("kaiser") || job.equals("adele") || job.equals("zero") || job.equals("bowmaster") || job.equals("marksman") || job.equals("pathfinder") || job.equals("windArcher") || job.equals("wildHunter") || job.equals("mercedes") || job.equals("kain") || job.equals("nightLords") || job.equals("shadowers") || job.equals("dualBlade") || job.equals("nightWalker") || job.equals("xenon") || job.equals("phantom") || job.equals("cadena") || job.equals("hoyoung") || job.equals("buccaneer") || job.equals("corsair") || job.equals("cannoneer") || job.equals("thunderBreaker") || job.equals("mechanic") || job.equals("shade") || job.equals("angelicBuster") || job.equals("ark")) {
				att += 30;
			}
		}
		if (usableItem[i].equals("extremeBluePotion")) {
			if (job.equals("magician(fire,poison)") || job.equals("magician(ice,lightning)") || job.equals("bishop") || job.equals("blazeWizard") || job.equals("battleMage") || job.equals("evan") || job.equals("luminous") || job.equals("illium") || job.equals("lara") || job.equals("kinesis")) {
				att += 30;
			}
		}
		if (usableItem[i].equals("unionsStrength")) {
			att += 30;
		}
		if (usableItem[i].equals("MVPSuperPowerBuff")) {
			att += 30;
		}
		if (usableItem[i].equals("guildBlessing")) {
			att += 20;
			guildBlessingFlag = false;
		}
		if (usableItem[i].equals("largerGuildBlessing")) {
			if (guildBlessingFlag) {
				att += 30;
			} else {
				att += 10;
			}
		}
		if (usableItem[i].equals("masarayusGiftAtmosphericEffect")) {
			att += 30;
		}
		if (usableItem[i].equals("atmosphericEffect")) {
			att += 30;
		}
		if (usableItem[i].equals("blessingOfThe250")) {
			att += 40;
			blessingOfTheLevelFlag = false;
		}
		if (usableItem[i].equals("blessingOfThe275")) {
			if (blessingOfTheLevelFlag) {
				att += 50;
			} else {
				att += 10;
			}
		}
		/* if(usableItem[i] == "advancedWeaponTempering") { critDamage += 5; } */
	}
} catch (Exception e) {
	System.out.println("소비아이템 미적용");
}

/* 표기할 정보에 대한 연산 */

// 주스탯 n%당 스탯
double statPerMainStatPercent = variedMainStat * (1 + (double) (mainStatPercent + 1) / 100) / (1 + (double) mainStatPercent / 100) - variedMainStat;

// 주스탯 n%당 공격력
double attPerMainStatPercent = ((variedMainStat * (1 + (double) (mainStatPercent + 1) / 100) + fixedMainStat) * 4 + subStat) / ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) * att - att;
double attPerMainStatPercent4 = ((variedMainStat * (1 + (double) (mainStatPercent + 4) / 100) + fixedMainStat) * 4 + subStat) / ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) * att - att;
double attPerMainStatPercent5 = ((variedMainStat * (1 + (double) (mainStatPercent + 5) / 100) + fixedMainStat) * 4 + subStat) / ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) * att - att;

// 공격력 n당 주스탯 %
double mainStatPercentPerAtt = ((((double) (att + 1) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 -  mainStatPercent;
double mainStatPercentPerAtt10 = ((((double) (att + 10) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 -  mainStatPercent;
double mainStatPercentPerAtt11 = ((((double) (att + 11) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 -  mainStatPercent;
double mainStatPercentPerAtt12 = ((((double) (att + 12) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 -  mainStatPercent;

// 공격력 n당 스탯
double statPerAtt = (((double) (att + 1) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerAtt3 = (((double) (att + 3) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerAtt5 = (((double) (att + 5) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerAtt6 = (((double) (att + 6) / att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;

// 크리데미지 n%당 주스탯 %
double mainStatPercentPerCritDamage = ((((double) (136 + critDamage) / (135 + critDamage) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 - mainStatPercent;
double mainStatPercentPerCritDamage3 = ((((double) (138 + critDamage) / (135 + critDamage) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 - mainStatPercent;
double mainStatPercentPerCritDamage8 = ((((double) (143 + critDamage) / (135 + critDamage) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 - mainStatPercent;

// 크리데미지 n%당 스탯
double statPerCritDamage = (((double) (136 + critDamage) / (135 + critDamage) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerCritDamage2 = (((double) (137 + critDamage) / (135 + critDamage) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;

// (보스)데미지 n%당 스탯
double statPerDamage = (((1 + (double) (damage + bossDamage + 1) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerDamage2 = (((1 + (double) (damage + bossDamage + 2) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerDamage3 = (((1 + (double) (damage + bossDamage + 3) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerDamage4 = (((1 + (double) (damage + bossDamage + 4) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerDamage5 = (((1 + (double) (damage + bossDamage + 5) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerDamage8 = (((1 + (double) (damage + bossDamage + 8) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;

// (보스)데미지 n%당 주스탯 %
double statPercentPerDamage = ((((1 + (double) (damage + bossDamage + 1) / 100) / (1 + (double) (damage + bossDamage) / 100) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / variedMainStat - 1) * 100 - mainStatPercent;

// 에디셔널 잠재능력, 주스탯 +16, +18을 주스탯 %로 환산 
double mainStatPercentPerMainStat16 = ((variedMainStat + 16) * (1 + (double) mainStatPercent / 100) / variedMainStat - 1) * 100 - mainStatPercent;
double mainStatPercentPerMainStat18 = ((variedMainStat + 18) * (1 + (double) mainStatPercent / 100) / variedMainStat - 1) * 100 - mainStatPercent;

// 에디셔널 잠재능력, 캐릭터 레벨 10당 주스탯 1을 주스탯 %로 환산 
double mainStatPercentPerStatPerCharacterLevels = ((variedMainStat + level / 10) * (1 + (double) mainStatPercent / 100) / variedMainStat - 1) * 100 - mainStatPercent;
double mainStatPercentPerStatPerCharacterLevels2 = ((variedMainStat + (level / 10) * 2) * (1 + (double) mainStatPercent / 100) / variedMainStat - 1) * 100 - mainStatPercent;

int increasingMainStat = (int) (variedMainStat / 100);
double finalDamageForBoss = 100 - (300 - (300 * ignoreDef / 100));

//쁘띠 루미너스(이퀄리브리엄), 블랙 바이킹 효율
double petiteLuminousEquilibriumEfficiency = ((((att + level / 20) / (double) att * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat) / (1 + (double) attPercent / 100);
double blackVikingEfficiency = 0.0;
if(job.equals("bowmaster") || job.equals("marksman") || job.equals("pathfinder") || job.equals("windArcher") || job.equals("wildHunter") || job.equals("mercedes") || job.equals("kain") || job.equals("corsair") || job.equals("mechanic")|| job.equals("angelicBuster")) {
	blackVikingEfficiency = statPerDamage2 + 5;
} else if (job.equals("hero") || job.equals("paladin") || job.equals("darkKnight") || job.equals("mihile") || job.equals("dawnWarrior") || job.equals("demonSlayer") || job.equals("blaster") || job.equals("aran") || job.equals("kaiser") || job.equals("adele") || job.equals("zero") || job.equals("nightLords") || job.equals("shadowers") || job.equals("dualBlade") || job.equals("nightWalker") || job.equals("phantom") || job.equals("cadena") || job.equals("hoyoung") || job.equals("buccaneer") || job.equals("cannoneer") || job.equals("thunderBreaker") || job.equals("shade") || job.equals("ark")) {
	blackVikingEfficiency = statPerDamage2 + (((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + 5) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
} else {
	blackVikingEfficiency = statPerDamage2;
}

// 공격력 n%당 보스데미지
double bossDamagePerAttPercent3 = ((1 + ((double) attPercent + 3) / 100) / (1 + (double) attPercent / 100) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;
double bossDamagePerAttPercent6 = ((1 + ((double) attPercent + 6) / 100) / (1 + (double) attPercent / 100) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;
double bossDamagePerAttPercent9 = ((1 + ((double) attPercent + 9) / 100) / (1 + (double) attPercent / 100) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;
double bossDamagePerAttPercent12 = ((1 + ((double) attPercent + 12) / 100) / (1 + (double) attPercent / 100) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;

// 보스데미지 n%당 공격력 %
double attPercentPerBossDamage20 = ((1 + (double) (damage + bossDamage + 20) / 100) / (1 + (double) (damage + bossDamage) / 100) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;
double attPercentPerBossDamage30 = ((1 + (double) (damage + bossDamage + 30) / 100) / (1 + (double) (damage + bossDamage) / 100) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;
double attPercentPerBossDamage35 = ((1 + (double) (damage + bossDamage + 35) / 100) / (1 + (double) (damage + bossDamage) / 100) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;
double attPercentPerBossDamage40 = ((1 + (double) (damage + bossDamage + 40) / 100) / (1 + (double) (damage + bossDamage) / 100) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;

// 방어율 무시 n%당 보스데미지
double bossDamagePerIgnoreDef15 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.15) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;
double bossDamagePerIgnoreDef30 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.3) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;
double bossDamagePerIgnoreDef35 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.35) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;
double bossDamagePerIgnoreDef40 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.4) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) (damage + bossDamage) / 100) - 1) * 100 - damage - bossDamage;

// 방어율 무시 n%당 공격력 %
double attPercentPerIgnoreDef15 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.15) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;
double attPercentPerIgnoreDef30 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.3) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;
double attPercentPerIgnoreDef35 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.35) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;
double attPercentPerIgnoreDef40 = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.4) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * (1 + (double) attPercent / 100) - 1) * 100 - attPercent;

// 방어율 무시 n%당 스탯
double statPerIgnoreDef5 = (((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.05) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;
double statPerIgnoreDef6 = (((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.06) / 100))) / (100 - (300 - (300 * ignoreDef / 100))) * ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - subStat) / 4 - fixedMainStat) / (1 + (double) mainStatPercent / 100) - variedMainStat;

// 공격력 %와 보스데미지 %의 효율 비교결과
String AttPercentVSbossDamage = null;
if(bossDamagePerAttPercent12 > 40) {
	AttPercentVSbossDamage = "현재 스펙을 기준으로 <b>공격력 %의 효율</b>이 보스데미지의 효율보다 <b>더 높습니다.</b>";
} else if(bossDamagePerAttPercent12 < 40) {
	AttPercentVSbossDamage = "현재 스펙을 기준으로 <b>보스데미지의 효율</b>이 공격력 %의 효율보다 <b>더 높습니다.</b>";
} else {
	AttPercentVSbossDamage = "현재 스펙을 기준으로 공격력 %와 보스데미지의 효율이 동일합니다.";
}

/* 링크스킬 효율 계산 */
double empiricalKnowledgeEfficiency = 0.0;
double thiefsCunningEfficiency = 0.0;
double pirateBlessingEfficiency = 0.0;
double cygnusBlessingEfficiency = 0.0;
double wildRageEfficiency = 0.0;
double furyUnleashedEfficiency = 0.0;
double hybridLogicEfficiency = 0.0;
double lightWashEfficiency = 0.0;
double timeToPrepareEfficiency = 0.0;
double unfairAdvantageEfficiency = 0.0;
double nobleFireEfficiency_solo = 0.0;
double nobleFireEfficiency_party = 0.0;
double tideOfBattleEfficiency = 0.0;
double solusEfficiency = 0.0;
double judgementEfficiency = 0.0;

if (empiricalKnowledgeFlag) {
	empiricalKnowledgeEfficiency = (((double) (damage + bossDamage) / ((damage + bossDamage) - 9)) * (finalDamageForBoss / (100 - (300 - (300 * ((ignoreDef - 9) / 0.91) / 100)))) - 1) * 100;
} else {
	empiricalKnowledgeEfficiency = (((double) ((damage + bossDamage) + 9) / (damage + bossDamage)) * ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.09) / 100))) / finalDamageForBoss) - 1) * 100;
}

if (thiefsCunningFlag) {
	thiefsCunningEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 9) - 1) * 100;
} else {
	thiefsCunningEfficiency = ((double) ((damage + bossDamage) + 9) / (damage + bossDamage) - 1) * 100;
}

if (pirateBlessingFlag) {
	pirateBlessingEfficiency = (((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) / (((variedMainStat - 70) * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat - 70) - 1) * 100;
} else {
	pirateBlessingEfficiency = ((((variedMainStat + 70) * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat + 70) / ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat - 70) - 1) * 100;
}

if (cygnusBlessingFlag) {
	cygnusBlessingEfficiency = ((double) att / (att - 25) - 1) * 100;
} else {
	cygnusBlessingEfficiency = ((double) (att + 25) / att - 1) * 100;
}

if (wildRageFlag) {
	wildRageEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 10) - 1) * 100;
} else {
	wildRageEfficiency = ((double) ((damage + bossDamage) + 10) / (damage + bossDamage) - 1) * 100;
}

if (furyUnleashedFlag) {
	furyUnleashedEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 15) - 1) * 100;
} else {
	furyUnleashedEfficiency = ((double) ((damage + bossDamage) + 15) / (damage + bossDamage) - 1) * 100;
}

if (hybridLogicFlag) {
	hybridLogicEfficiency = (((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) / ((variedMainStat * (1 + (double) (mainStatPercent - 10) / 100) + fixedMainStat) * 4 + subStat) - 1) * 100;
} else {
	hybridLogicEfficiency = (((variedMainStat * (1 + (double) (mainStatPercent + 10) / 100) + fixedMainStat) * 4 + subStat) / ((variedMainStat * (1 + (double) mainStatPercent / 100) + fixedMainStat) * 4 + subStat) - 1) * 100;
}

if (lightWashFlag) {
	lightWashEfficiency = (finalDamageForBoss / (100 - (300 - (300 * ((ignoreDef - 15) / 0.85) / 100))) - 1) * 100;
} else {
	lightWashEfficiency = ((100 - (300 - (300 * (ignoreDef + (100 - ignoreDef) * 0.15) / 100))) / finalDamageForBoss - 1) * 100;
}

if (timeToPrepareFlag) {
	timeToPrepareEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 7) - 1) * 100;
} else {
	timeToPrepareEfficiency = ((double) ((damage + bossDamage) + 7) / (damage + bossDamage) - 1) * 100;
}

if (unfairAdvantageFlag) {
	unfairAdvantageEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 12) - 1) * 100;
} else {
	unfairAdvantageEfficiency = ((double) ((damage + bossDamage) + 12) / (damage + bossDamage) - 1) * 100;
}

if (nobleFireFlag) {
	nobleFireEfficiency_solo = ((double) (damage + bossDamage) / ((damage + bossDamage) - 6) - 1) * 100;
	nobleFireEfficiency_party = ((double) (damage + bossDamage) / ((damage + bossDamage) - 12) - 1) * 100;
} else {
	nobleFireEfficiency_solo = ((double) ((damage + bossDamage) + 6) / (damage + bossDamage) - 1) * 100;
	nobleFireEfficiency_party = ((double) ((damage + bossDamage) + 12) / (damage + bossDamage) - 1) * 100;
}

if (tideOfBattleFlag) {
	tideOfBattleEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 10) - 1) * 100;
} else {
	tideOfBattleEfficiency = ((double) ((damage + bossDamage) + 10) / (damage + bossDamage) - 1) * 100;
}

if (solusFlag) {
	solusEfficiency = ((double) (damage + bossDamage) / ((damage + bossDamage) - 11) - 1) * 100;
} else {
	solusEfficiency = ((double) ((damage + bossDamage) + 11) / (damage + bossDamage) - 1) * 100;
}

if (judgementFlag) {
	judgementEfficiency = (((double) (135 + critDamage) / 100) / ((double) (135 + critDamage - 4) / 100) - 1) * 100;
} else {
	judgementEfficiency = (((double) (135 + critDamage + 4) / 100) / ((double) (135 + critDamage) / 100) - 1) * 100;
}

/* double값 필요한 소수점까지 표기하도록 String으로 가공 */

// 방어율 무시
ignoreDef = (int) (ignoreDef * 100) / (double) 100;
String ignoreDefTxt = String.valueOf(ignoreDef);

//주스탯 n%당 스탯
statPerMainStatPercent = (int) (statPerMainStatPercent * 100) / (double) 100;
String statPerMainStatPercentTxt = String.valueOf(statPerMainStatPercent);

//주스탯 n%당 공격력
attPerMainStatPercent = (int) (attPerMainStatPercent * 100) / (double) 100;
attPerMainStatPercent4 = (int) (attPerMainStatPercent4 * 100) / (double) 100;
attPerMainStatPercent5 = (int) (attPerMainStatPercent5 * 100) / (double) 100;
String attPerMainStatPercentTxt = String.valueOf(attPerMainStatPercent);
String attPerMainStatPercent4Txt = String.valueOf(attPerMainStatPercent4);
String attPerMainStatPercent5Txt = String.valueOf(attPerMainStatPercent5);

//공격력 n당 주스탯 %
mainStatPercentPerAtt = (int) (mainStatPercentPerAtt * 100) / (double) 100;
mainStatPercentPerAtt10 = (int) (mainStatPercentPerAtt * 100) * 10 / (double) 100;
mainStatPercentPerAtt11 = (int) (mainStatPercentPerAtt * 100) * 11 / (double) 100;
mainStatPercentPerAtt12 = (int) (mainStatPercentPerAtt * 100) * 12 / (double) 100;
String mainStatPercentPerAttTxt = String.valueOf(mainStatPercentPerAtt);
String mainStatPercentPerAtt10Txt = String.valueOf(mainStatPercentPerAtt10);
String mainStatPercentPerAtt11Txt = String.valueOf(mainStatPercentPerAtt11);
String mainStatPercentPerAtt12Txt = String.valueOf(mainStatPercentPerAtt12);

//공격력 n당 스탯
statPerAtt = (int) (statPerAtt * 100) / (double) 100;
statPerAtt3 = (int) (statPerAtt3 * 100) / (double) 100;
statPerAtt5 = (int) (statPerAtt5 * 100) / (double) 100;
statPerAtt6 = (int) (statPerAtt6 * 100) / (double) 100;
String statPerAttTxt = String.valueOf(statPerAtt);
String statPerAtt3Txt = String.valueOf(statPerAtt3);
String statPerAtt5Txt = String.valueOf(statPerAtt5);
String statPerAtt6Txt = String.valueOf(statPerAtt6);

//크리데미지 n%당 주스탯 %
mainStatPercentPerCritDamage = (int) (mainStatPercentPerCritDamage * 100) / (double) 100;
mainStatPercentPerCritDamage3 = (int) (mainStatPercentPerCritDamage3 * 100) / (double) 100;
mainStatPercentPerCritDamage8 = (int) (mainStatPercentPerCritDamage8 * 100) / (double) 100;
String mainStatPercentPerCritDamageTxt = String.valueOf(mainStatPercentPerCritDamage);
String mainStatPercentPerCritDamage3Txt = String.valueOf(mainStatPercentPerCritDamage3);
String mainStatPercentPerCritDamage8Txt = String.valueOf(mainStatPercentPerCritDamage8);

//크리데미지 n%당 스탯
statPerCritDamage = (int) (statPerCritDamage * 100) / (double) 100;
statPerCritDamage2 = (int) (statPerCritDamage2 * 100) / (double) 100;
String statPerCritDamageTxt = String.valueOf(statPerCritDamage);
String statPerCritDamage2Txt = String.valueOf(statPerCritDamage2);

//(보스)데미지 n%당 스탯
statPerDamage = (int) (statPerDamage * 100) / (double) 100;
statPerDamage2 = (int) (statPerDamage2 * 100) / (double) 100;
statPerDamage3 = (int) (statPerDamage3 * 100) / (double) 100;
statPerDamage4 = (int) (statPerDamage4 * 100) / (double) 100;
statPerDamage5 = (int) (statPerDamage5 * 100) / (double) 100;
statPerDamage8 = (int) (statPerDamage8 * 100) / (double) 100;
String statPerDamageTxt = String.valueOf(statPerDamage);
String statPerDamage2Txt = String.valueOf(statPerDamage2);
String statPerDamage3Txt = String.valueOf(statPerDamage3);
String statPerDamage4Txt = String.valueOf(statPerDamage4);
String statPerDamage5Txt = String.valueOf(statPerDamage5);
String statPerDamage8Txt = String.valueOf(statPerDamage8);

//(보스)데미지 n%당 주스탯 %
statPercentPerDamage = (int) (statPercentPerDamage * 100) / (double) 100;
String statPercentPerDamageTxt = String.valueOf(statPercentPerDamage);

//에디셔널 잠재능력, 주스탯 +16, +18을 주스탯 %로 환산 
mainStatPercentPerMainStat16 = (int) (mainStatPercentPerMainStat16 * 100) / (double) 100;
mainStatPercentPerMainStat18 = (int) (mainStatPercentPerMainStat18 * 100) / (double) 100;
String mainStatPercentPerMainStat16Txt = String.valueOf(mainStatPercentPerMainStat16);
String mainStatPercentPerMainStat18Txt = String.valueOf(mainStatPercentPerMainStat18);

//에디셔널 잠재능력, 캐릭터 레벨 10당 주스탯 1을 주스탯 %로 환산 
mainStatPercentPerStatPerCharacterLevels = (int) (mainStatPercentPerStatPerCharacterLevels * 100) / (double) 100;
mainStatPercentPerStatPerCharacterLevels2 = (int) (mainStatPercentPerStatPerCharacterLevels2 * 100) / (double) 100;
String mainStatPercentPerStatPerCharacterLevelsTxt = String.valueOf(mainStatPercentPerStatPerCharacterLevels);
String mainStatPercentPerStatPerCharacterLevels2Txt = String.valueOf(mainStatPercentPerStatPerCharacterLevels2);

finalDamageForBoss = (int) (finalDamageForBoss * 100) / (double) 100;
String finalDamageForBossTxt = String.valueOf(finalDamageForBoss);

// 쁘띠 루미너스(이퀄리브리엄), 블랙바이킹 효율
petiteLuminousEquilibriumEfficiency = (int) (petiteLuminousEquilibriumEfficiency * 100) / (double) 100;
blackVikingEfficiency = (int) (blackVikingEfficiency * 100) / (double) 100;
String petiteLuminousEquilibriumEfficiencyTxt = String.valueOf(petiteLuminousEquilibriumEfficiency);
String blackVikingEfficiencyTxt = String.valueOf(blackVikingEfficiency);

//공격력 n%당 보스데미지
bossDamagePerAttPercent3 = (int) (bossDamagePerAttPercent3 * 100) / (double) 100;
bossDamagePerAttPercent6 = (int) (bossDamagePerAttPercent6 * 100) / (double) 100;
bossDamagePerAttPercent9 = (int) (bossDamagePerAttPercent9 * 100) / (double) 100;
bossDamagePerAttPercent12 = (int) (bossDamagePerAttPercent12 * 100) / (double) 100;
String bossDamagePerAttPercent3Txt = String.valueOf(bossDamagePerAttPercent3);
String bossDamagePerAttPercent6Txt = String.valueOf(bossDamagePerAttPercent6);
String bossDamagePerAttPercent9Txt = String.valueOf(bossDamagePerAttPercent9);
String bossDamagePerAttPercent12Txt = String.valueOf(bossDamagePerAttPercent12);

//보스데미지 n%당 공격력 %
attPercentPerBossDamage20 = (int) (attPercentPerBossDamage20 * 100) / (double) 100;
attPercentPerBossDamage30 = (int) (attPercentPerBossDamage30 * 100) / (double) 100;
attPercentPerBossDamage35 = (int) (attPercentPerBossDamage35 * 100) / (double) 100;
attPercentPerBossDamage40 = (int) (attPercentPerBossDamage40 * 100) / (double) 100;
String attPercentPerBossDamage20Txt = String.valueOf(attPercentPerBossDamage20);
String attPercentPerBossDamage30Txt = String.valueOf(attPercentPerBossDamage30);
String attPercentPerBossDamage35Txt = String.valueOf(attPercentPerBossDamage35);
String attPercentPerBossDamage40Txt = String.valueOf(attPercentPerBossDamage40);

// 방어율 무시 n%당 보스데미지
bossDamagePerIgnoreDef15 = (int) (bossDamagePerIgnoreDef15 * 100) / (double) 100;
bossDamagePerIgnoreDef30 = (int) (bossDamagePerIgnoreDef30 * 100) / (double) 100;
bossDamagePerIgnoreDef35 = (int) (bossDamagePerIgnoreDef35 * 100) / (double) 100;
bossDamagePerIgnoreDef40 = (int) (bossDamagePerIgnoreDef40 * 100) / (double) 100;
String bossDamagePerIgnoreDef15Txt = String.valueOf(bossDamagePerIgnoreDef15);
String bossDamagePerIgnoreDef30Txt = String.valueOf(bossDamagePerIgnoreDef30);
String bossDamagePerIgnoreDef35Txt = String.valueOf(bossDamagePerIgnoreDef35);
String bossDamagePerIgnoreDef40Txt = String.valueOf(bossDamagePerIgnoreDef40);

// 방어율 무시 n%당 공격력 %
attPercentPerIgnoreDef15 = (int) (attPercentPerIgnoreDef15 * 100) / (double) 100;
attPercentPerIgnoreDef30 = (int) (attPercentPerIgnoreDef30 * 100) / (double) 100;
attPercentPerIgnoreDef35 = (int) (attPercentPerIgnoreDef35 * 100) / (double) 100;
attPercentPerIgnoreDef40 = (int) (attPercentPerIgnoreDef40 * 100) / (double) 100;
String attPercentPerIgnoreDef15Txt = String.valueOf(attPercentPerIgnoreDef15);
String attPercentPerIgnoreDef30Txt = String.valueOf(attPercentPerIgnoreDef30);
String attPercentPerIgnoreDef35Txt = String.valueOf(attPercentPerIgnoreDef35);
String attPercentPerIgnoreDef40Txt = String.valueOf(attPercentPerIgnoreDef40);

// 방어율 무시 n%당 스탯
statPerIgnoreDef5 = (int) (statPerIgnoreDef5 * 100) / (double) 100;
statPerIgnoreDef6 = (int) (statPerIgnoreDef6 * 100) / (double) 100;
String statPerIgnoreDef5Txt = String.valueOf(statPerIgnoreDef5);
String statPerIgnoreDef6Txt = String.valueOf(statPerIgnoreDef6);

// 링크스킬 효율
empiricalKnowledgeEfficiency = (int) (empiricalKnowledgeEfficiency * 100) / (double) 100;
thiefsCunningEfficiency = (int) (thiefsCunningEfficiency * 100) / (double) 100;
pirateBlessingEfficiency = (int) (pirateBlessingEfficiency * 100) / (double) 100;
cygnusBlessingEfficiency = (int) (cygnusBlessingEfficiency * 100) / (double) 100;
wildRageEfficiency = (int) (wildRageEfficiency * 100) / (double) 100;
furyUnleashedEfficiency = (int) (furyUnleashedEfficiency * 100) / (double) 100;
hybridLogicEfficiency = (int) (hybridLogicEfficiency * 100) / (double) 100;
lightWashEfficiency = (int) (lightWashEfficiency * 100) / (double) 100;
timeToPrepareEfficiency = (int) (timeToPrepareEfficiency * 100) / (double) 100;
unfairAdvantageEfficiency = (int) (unfairAdvantageEfficiency * 100) / (double) 100;
nobleFireEfficiency_solo = (int) (nobleFireEfficiency_solo * 100) / (double) 100;
nobleFireEfficiency_party = (int) (nobleFireEfficiency_party * 100) / (double) 100;
tideOfBattleEfficiency = (int) (tideOfBattleEfficiency * 100) / (double) 100;
solusEfficiency = (int) (solusEfficiency * 100) / (double) 100;
judgementEfficiency = (int) (judgementEfficiency * 100) / (double) 100;
String empiricalKnowledgeEfficiencyTxt = String.valueOf(empiricalKnowledgeEfficiency);
String thiefsCunningEfficiencyTxt = String.valueOf(thiefsCunningEfficiency);
String pirateBlessingEfficiencyTxt = String.valueOf(pirateBlessingEfficiency);
String cygnusBlessingEfficiencyTxt = String.valueOf(cygnusBlessingEfficiency);
String wildRageEfficiencyTxt = String.valueOf(wildRageEfficiency);
String furyUnleashedEfficiencyTxt = String.valueOf(furyUnleashedEfficiency);
String hybridLogicEfficiencyTxt = String.valueOf(hybridLogicEfficiency);
String lightWashEfficiencyTxt = String.valueOf(lightWashEfficiency);
String timeToPrepareEfficiencyTxt = String.valueOf(timeToPrepareEfficiency);
String unfairAdvantageEfficiencyTxt = String.valueOf(unfairAdvantageEfficiency);
String nobleFireEfficiency_soloTxt = String.valueOf(nobleFireEfficiency_solo);
String nobleFireEfficiency_partyTxt = String.valueOf(nobleFireEfficiency_party);
String tideOfBattleEfficiencyTxt = String.valueOf(tideOfBattleEfficiency);
String solusEfficiencyTxt = String.valueOf(solusEfficiency);
String judgementEfficiencyTxt = String.valueOf(judgementEfficiency);

/* 직업 한국어로 변경 */
if (job.equals("hero")) {
	job = "히어로";
} else if (job.equals("paladin")) {
	job = "팔라딘";
} else if (job.equals("darkKnight")) {
	job = "다크나이트";
} else if (job.equals("mihile")) {
	job = "미하일";
} else if (job.equals("dawnWarrior")) {
	job = "소울마스터";
} else if (job.equals("demonAvenger")) {
	job = "데몬어벤져";
} else if (job.equals("demonSlayer")) {
	job = "데몬슬레이어";
} else if (job.equals("blaster")) {
	job = "블래스터";
} else if (job.equals("aran")) {
	job = "아란";
} else if (job.equals("kaiser")) {
	job = "카이저";
} else if (job.equals("adele")) {
	job = "아델";
} else if (job.equals("zero")) {
	job = "제로";
} else if (job.equals("magician(fire,poison)")) {
	job = "아크메이지(불,독)";
} else if (job.equals("magician(ice,lightning)")) {
	job = "아크메이지(썬,콜)";
} else if (job.equals("bishop")) {
	job = "비숍";
} else if (job.equals("blazeWizard")) {
	job = "플레임위자드";
} else if (job.equals("battleMage")) {
	job = "배틀메이지";
} else if (job.equals("evan")) {
	job = "에반";
} else if (job.equals("luminous")) {
	job = "루미너스";
} else if (job.equals("illium")) {
	job = "일리움";
} else if (job.equals("lara")) {
	job = "라라";
} else if (job.equals("kinesis")) {
	job = "키네시스";
} else if (job.equals("bowmaster")) {
	job = "보우마스터";
} else if (job.equals("marksman")) {
	job = "신궁";
} else if (job.equals("pathfinder")) {
	job = "패스파인더";
} else if (job.equals("windArcher")) {
	job = "윈드브레이커";
} else if (job.equals("wildHunter")) {
	job = "와일드헌터";
} else if (job.equals("mercedes")) {
	job = "메르세데스";
} else if (job.equals("kain")) {
	job = "카인";
} else if (job.equals("nightLords")) {
	job = "나이트로드";
} else if (job.equals("shadowers")) {
	job = "섀도어";
} else if (job.equals("dualBlade")) {
	job = "듀얼블레이드";
} else if (job.equals("nightWalker")) {
	job = "나이트워커";
} else if (job.equals("xenon")) {
	job = "제논";
} else if (job.equals("phantom")) {
	job = "팬텀";
} else if (job.equals("cadena")) {
	job = "카데나";
} else if (job.equals("hoyoung")) {
	job = "호영";
} else if (job.equals("buccaneer")) {
	job = "바이퍼";
} else if (job.equals("corsair")) {
	job = "캡틴";
} else if (job.equals("cannoneer")) {
	job = "캐논슈터";
} else if (job.equals("thunderBreaker")) {
	job = "스트라이커";
} else if (job.equals("mechanic")) {
	job = "메카닉";
} else if (job.equals("shade")) {
	job = "은월";
} else if (job.equals("angelicBuster")) {
	job = "엔젤릭버스터";
} else if (job.equals("ark")) {
	job = "아크";
}

/* 정보 저장, StatCalculatorResult로 넘길 준비 */

// 원형 그대로 전송
session.setAttribute("job", job);
session.setAttribute("mainStatPercent", mainStatPercentInt); // 스탯%
session.setAttribute("variedMainStat", variedMainStat); // 스탯%의 영향을 받는 주스탯
session.setAttribute("fixedMainStat", fixedMainStat); // 스탯%의 영향을 받지 않는 주스탯
session.setAttribute("att", att); // 공격력 or 마력
session.setAttribute("weaponConstant", weaponConstant);
session.setAttribute("jobConstant", jobConstant);
session.setAttribute("finalDamage", finalDamage);
session.setAttribute("level", level);
session.setAttribute("statAtt", statAtt);
session.setAttribute("mainStatUsedMW", mainStatUsedMW);
session.setAttribute("mainStatDisusedMW", mainStatDisusedMW);
session.setAttribute("subStat", subStat);
session.setAttribute("unionStat", unionStat);
session.setAttribute("hyperStat", hyperStat);
session.setAttribute("abilityStat", abilityStat);
session.setAttribute("arcaneStat", arcaneStat);
session.setAttribute("authenticStat", authenticStat);
session.setAttribute("attPercent", attPercent);
session.setAttribute("damage", damage);
session.setAttribute("bossDamage", bossDamage);
session.setAttribute("critDamage", critDamage);
session.setAttribute("ignoreDef", ignoreDef);

session.setAttribute("statPerMainStatPercent", statPerMainStatPercent);
session.setAttribute("attPerMainStatPercent", attPerMainStatPercent);
session.setAttribute("attPerMainStatPercent4", attPerMainStatPercent4);
session.setAttribute("attPerMainStatPercent5", attPerMainStatPercent5);
session.setAttribute("mainStatPercentPerAtt", mainStatPercentPerAtt);
session.setAttribute("mainStatPercentPerAtt10", mainStatPercentPerAtt10);
session.setAttribute("mainStatPercentPerAtt11", mainStatPercentPerAtt11);
session.setAttribute("mainStatPercentPerAtt12", mainStatPercentPerAtt12);
session.setAttribute("mainStatPercentPerMainStat16", mainStatPercentPerMainStat16);
session.setAttribute("mainStatPercentPerMainStat18", mainStatPercentPerMainStat18);
session.setAttribute("statPerAtt", statPerAtt);
session.setAttribute("statPerAtt3", statPerAtt3);
session.setAttribute("statPerAtt5", statPerAtt5);
session.setAttribute("statPerAtt6", statPerAtt6);
session.setAttribute("mainStatPercentPerCritDamage", mainStatPercentPerCritDamage);
session.setAttribute("mainStatPercentPerCritDamage3", mainStatPercentPerCritDamage3);
session.setAttribute("mainStatPercentPerCritDamage8", mainStatPercentPerCritDamage8);
session.setAttribute("statPerCritDamage", statPerCritDamage);
session.setAttribute("statPerCritDamage2", statPerCritDamage2);
session.setAttribute("statPerDamage", statPerDamage);
session.setAttribute("statPerDamage2", statPerDamage2);
session.setAttribute("statPerDamage3", statPerDamage3);
session.setAttribute("statPerDamage4", statPerDamage4);
session.setAttribute("statPerDamage5", statPerDamage5);
session.setAttribute("statPerDamage8", statPerDamage8);
session.setAttribute("statPercentPerDamage", statPercentPerDamage);
session.setAttribute("mainStatPercentPerStatPerCharacterLevels", mainStatPercentPerStatPerCharacterLevels);
session.setAttribute("mainStatPercentPerStatPerCharacterLevels2", mainStatPercentPerStatPerCharacterLevels2);
session.setAttribute("increasingMainStat", increasingMainStat);
session.setAttribute("finalDamageForBoss", finalDamageForBoss);
session.setAttribute("petiteLuminousEquilibriumEfficiency", petiteLuminousEquilibriumEfficiency);
session.setAttribute("blackVikingEfficiency", blackVikingEfficiency);
session.setAttribute("bossDamagePerAttPercent3", bossDamagePerAttPercent3);
session.setAttribute("bossDamagePerAttPercent6", bossDamagePerAttPercent6);
session.setAttribute("bossDamagePerAttPercent9", bossDamagePerAttPercent9);
session.setAttribute("bossDamagePerAttPercent12", bossDamagePerAttPercent12);
session.setAttribute("attPercentPerBossDamage20", attPercentPerBossDamage20);
session.setAttribute("attPercentPerBossDamage30", attPercentPerBossDamage30);
session.setAttribute("attPercentPerBossDamage35", attPercentPerBossDamage35);
session.setAttribute("attPercentPerBossDamage40", attPercentPerBossDamage40);
session.setAttribute("bossDamagePerIgnoreDef15", bossDamagePerIgnoreDef15);
session.setAttribute("bossDamagePerIgnoreDef30", bossDamagePerIgnoreDef30);
session.setAttribute("bossDamagePerIgnoreDef35", bossDamagePerIgnoreDef35);
session.setAttribute("bossDamagePerIgnoreDef40", bossDamagePerIgnoreDef40);
session.setAttribute("attPercentPerIgnoreDef15", attPercentPerIgnoreDef15);
session.setAttribute("attPercentPerIgnoreDef30", attPercentPerIgnoreDef30);
session.setAttribute("attPercentPerIgnoreDef35", attPercentPerIgnoreDef35);
session.setAttribute("attPercentPerIgnoreDef40", attPercentPerIgnoreDef40);
session.setAttribute("statPerIgnoreDef5", statPerIgnoreDef5);
session.setAttribute("statPerIgnoreDef6", statPerIgnoreDef6);

session.setAttribute("empiricalKnowledgeEfficiency", empiricalKnowledgeEfficiency);
session.setAttribute("thiefsCunningEfficiency", thiefsCunningEfficiency);
session.setAttribute("pirateBlessingEfficiency", pirateBlessingEfficiency);
session.setAttribute("cygnusBlessingEfficiency", cygnusBlessingEfficiency);
session.setAttribute("wildRageEfficiency", wildRageEfficiency);
session.setAttribute("furyUnleashedEfficiency", furyUnleashedEfficiency);
session.setAttribute("hybridLogicEfficiency", hybridLogicEfficiency);
session.setAttribute("lightWashEfficiency", lightWashEfficiency);
session.setAttribute("timeToPrepareEfficiency", timeToPrepareEfficiency);
session.setAttribute("unfairAdvantageEfficiency", unfairAdvantageEfficiency);
session.setAttribute("nobleFireEfficiency_solo", nobleFireEfficiency_solo);
session.setAttribute("nobleFireEfficiency_party", nobleFireEfficiency_party);
session.setAttribute("tideOfBattleEfficiency", tideOfBattleEfficiency);
session.setAttribute("solusEfficiency", solusEfficiency);
session.setAttribute("judgementEfficiency", judgementEfficiency);

// String 값으로 전송
session.setAttribute("ignoreDefTxt", ignoreDefTxt);

session.setAttribute("statPerMainStatPercentTxt", statPerMainStatPercentTxt);
session.setAttribute("attPerMainStatPercentTxt", attPerMainStatPercentTxt);
session.setAttribute("attPerMainStatPercent4Txt", attPerMainStatPercent4Txt);
session.setAttribute("attPerMainStatPercent5Txt", attPerMainStatPercent5Txt);
session.setAttribute("mainStatPercentPerAttTxt", mainStatPercentPerAttTxt);
session.setAttribute("mainStatPercentPerAtt10Txt", mainStatPercentPerAtt10Txt);
session.setAttribute("mainStatPercentPerAtt11Txt", mainStatPercentPerAtt11Txt);
session.setAttribute("mainStatPercentPerAtt12Txt", mainStatPercentPerAtt12Txt);
session.setAttribute("mainStatPercentPerMainStat16Txt", mainStatPercentPerMainStat16Txt);
session.setAttribute("mainStatPercentPerMainStat18Txt", mainStatPercentPerMainStat18Txt);
session.setAttribute("statPerAttTxt", statPerAttTxt);
session.setAttribute("statPerAtt3Txt", statPerAtt3Txt);
session.setAttribute("statPerAtt5Txt", statPerAtt5Txt);
session.setAttribute("statPerAtt6Txt", statPerAtt6Txt);
session.setAttribute("mainStatPercentPerCritDamageTxt", mainStatPercentPerCritDamageTxt);
session.setAttribute("mainStatPercentPerCritDamage3Txt", mainStatPercentPerCritDamage3Txt);
session.setAttribute("mainStatPercentPerCritDamage8Txt", mainStatPercentPerCritDamage8Txt);
session.setAttribute("statPerCritDamageTxt", statPerCritDamageTxt);
session.setAttribute("statPerCritDamage2Txt", statPerCritDamage2Txt);
session.setAttribute("statPerDamageTxt", statPerDamageTxt);
session.setAttribute("statPerDamage2Txt", statPerDamage2Txt);
session.setAttribute("statPerDamage3Txt", statPerDamage3Txt);
session.setAttribute("statPerDamage4Txt", statPerDamage4Txt);
session.setAttribute("statPerDamage5Txt", statPerDamage5Txt);
session.setAttribute("statPerDamage8Txt", statPerDamage8Txt);
session.setAttribute("statPercentPerDamageTxt", statPercentPerDamageTxt);
session.setAttribute("mainStatPercentPerStatPerCharacterLevelsTxt", mainStatPercentPerStatPerCharacterLevelsTxt);
session.setAttribute("mainStatPercentPerStatPerCharacterLevels2Txt", mainStatPercentPerStatPerCharacterLevels2Txt);
session.setAttribute("finalDamageForBossTxt", finalDamageForBossTxt);
session.setAttribute("petiteLuminousEquilibriumEfficiencyTxt", petiteLuminousEquilibriumEfficiencyTxt);
session.setAttribute("blackVikingEfficiencyTxt", blackVikingEfficiencyTxt);
session.setAttribute("bossDamagePerAttPercent3Txt", bossDamagePerAttPercent3Txt);
session.setAttribute("bossDamagePerAttPercent6Txt", bossDamagePerAttPercent6Txt);
session.setAttribute("bossDamagePerAttPercent9Txt", bossDamagePerAttPercent9Txt);
session.setAttribute("bossDamagePerAttPercent12Txt", bossDamagePerAttPercent12Txt);
session.setAttribute("attPercentPerBossDamage20Txt", attPercentPerBossDamage20Txt);
session.setAttribute("attPercentPerBossDamage30Txt", attPercentPerBossDamage30Txt);
session.setAttribute("attPercentPerBossDamage35Txt", attPercentPerBossDamage35Txt);
session.setAttribute("attPercentPerBossDamage40Txt", attPercentPerBossDamage40Txt);
session.setAttribute("AttPercentVSbossDamage", AttPercentVSbossDamage);
session.setAttribute("bossDamagePerIgnoreDef15Txt", bossDamagePerIgnoreDef15Txt);
session.setAttribute("bossDamagePerIgnoreDef30Txt", bossDamagePerIgnoreDef30Txt);
session.setAttribute("bossDamagePerIgnoreDef35Txt", bossDamagePerIgnoreDef35Txt);
session.setAttribute("bossDamagePerIgnoreDef40Txt", bossDamagePerIgnoreDef40Txt);
session.setAttribute("attPercentPerIgnoreDef15Txt", attPercentPerIgnoreDef15Txt);
session.setAttribute("attPercentPerIgnoreDef30Txt", attPercentPerIgnoreDef30Txt);
session.setAttribute("attPercentPerIgnoreDef35Txt", attPercentPerIgnoreDef35Txt);
session.setAttribute("attPercentPerIgnoreDef40Txt", attPercentPerIgnoreDef40Txt);
session.setAttribute("statPerIgnoreDef5Txt", statPerIgnoreDef5Txt);
session.setAttribute("statPerIgnoreDef6Txt", statPerIgnoreDef6Txt);

session.setAttribute("empiricalKnowledgeEfficiencyTxt", empiricalKnowledgeEfficiencyTxt);
session.setAttribute("thiefsCunningEfficiencyTxt", thiefsCunningEfficiencyTxt);
session.setAttribute("pirateBlessingEfficiencyTxt", pirateBlessingEfficiencyTxt);
session.setAttribute("cygnusBlessingEfficiencyTxt", cygnusBlessingEfficiencyTxt);
session.setAttribute("wildRageEfficiencyTxt", wildRageEfficiencyTxt);
session.setAttribute("furyUnleashedEfficiencyTxt", furyUnleashedEfficiencyTxt);
session.setAttribute("hybridLogicEfficiencyTxt", hybridLogicEfficiencyTxt);
session.setAttribute("lightWashEfficiencyTxt", lightWashEfficiencyTxt);
session.setAttribute("timeToPrepareEfficiencyTxt", timeToPrepareEfficiencyTxt);
session.setAttribute("unfairAdvantageEfficiencyTxt", unfairAdvantageEfficiencyTxt);
session.setAttribute("nobleFireEfficiency_soloTxt", nobleFireEfficiency_soloTxt);
session.setAttribute("nobleFireEfficiency_partyTxt", nobleFireEfficiency_partyTxt);
session.setAttribute("tideOfBattleEfficiencyTxt", tideOfBattleEfficiencyTxt);
session.setAttribute("solusEfficiencyTxt", solusEfficiencyTxt);
session.setAttribute("judgementEfficiencyTxt", judgementEfficiencyTxt);

/* StatCalculatorResult.jsp로 이동 */
response.sendRedirect("StatCalculatorResult.jsp");
%>
Return-Path: <linux-s390+bounces-10234-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5BA9AF2E
	for <lists+linux-s390@lfdr.de>; Thu, 24 Apr 2025 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD01172468
	for <lists+linux-s390@lfdr.de>; Thu, 24 Apr 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C8817A316;
	Thu, 24 Apr 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qvj1onx4"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E815E5DC
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501820; cv=none; b=pGzfo6eSoJoO3MC0dmov6jFfgiWx5KvxFfk5ZJBi6YFXT0Kel9oEp2ztEajfD/eTvghFW4YUOzR0sZRjFBjtHouxvDWzLR8z0hpYzt8KNo1JJM+OEU/fOcBWqVVe0vqNFoXjrMKSppiaDUzCFUqJSyylP2wTBbCqoYDH/Ry4oS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501820; c=relaxed/simple;
	bh=BuXxYLPsYEpN68iSPceYTH1qWzX5SEH1e1XVHwOdMvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1EjME6b8Va9QnGzbxt/a8BrhhqvoZetb/IOWhNbY59G9FPfiKtDb3LVujT7X5aVGeYWpwmetmBNZk4bMWPiI9pTKiBj2kRMKJc1Qf1+0OxNvnnAIJSR2diVCJf0sbYJHOjcQGXMWTAegOypVuhtfoxEHz93Syex1vCPqiBqenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qvj1onx4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8YiZg029581;
	Thu, 24 Apr 2025 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sv7Z5j9qVv6i0lI2v
	25i4eTrZ6p9GbGsXjL9PgyeHzE=; b=Qvj1onx4jAivimLFPMsSiSq8HKmjABbqH
	eGAZt7fGRXNwhILrBDztcrgCZgEl7RiLJ0nHPtfFrWlweSu2qx6unN+rgJ6fROel
	K6KOB7ZxKoNwCu3ursgwj4uE2oFVV+s/2qmGYlRBzWW2JeEByfs7+gPaKoCMCsTv
	2IAxM+H68TAEf6MXeGn8suCMj6LM161Mg6zRR7CIakSFLJXNWY09uhnq4imTlVvH
	cElQN42IHboZeoBejOSh15XtZZujaVCgQ66LeR/Wn/cg5mb1/LpffVXw80AaQ39z
	jkgwiltZmMZzDFjKpBVGJKHimUfqushdhi7q4dgtogqGWY/7U1icQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aabu9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBTbHe028421;
	Thu, 24 Apr 2025 13:36:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvrcgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaQgi54788570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6E620040;
	Thu, 24 Apr 2025 13:36:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 842942004B;
	Thu, 24 Apr 2025 13:36:25 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:25 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 12/25] s390/zcrypt: Remove CCA and EP11 card and domain info caches
Date: Thu, 24 Apr 2025 15:36:06 +0200
Message-ID: <20250424133619.16495-13-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfXz6O/3YW+lMz0 kIPEpjH46+vpPPdg8qXFDUG+Oh9yq8pe3xjEPJsSAk6Io62JCBc2tN2Rh0smvohuoAV/08kM9eE Zn5kjFHjEW9k7nhYk4jpqIHfz/OMKQJAaf5ErzWtLc4oN2qDVi4Mv4GtnQBHD/LuFM2HPoEjxpw
 3r0daSLTezQbw7BltzCB1qOEofLjz1G7dR4bGQakJIeRMtqccI2vAlDGXl3HqogW3MN/vesDJ98 NFnW3tsnmF8m9rCKa6UugVFnULhYYzPFvxG9y7jdMQq8NoYLUEviA0k5atioXIr1sgogIUAOdgW 1/HmbDnbhoW9IAFqS8ZuY6DhZonVZL446Bp3YTb5qUfhohaP+mh3Hco5oqbA2k/zHewRYMsXsaV
 Tgnao5ORuUp0T4/uvLN/b00yOYF1yxxDhiSXbqcJUCfPy+mhFORJKV1mDh/bGkG94dLofL6u
X-Proofpoint-ORIG-GUID: 1b0TbwS9XpzVBCU0fYuoEDxN97X014N5
X-Proofpoint-GUID: 1b0TbwS9XpzVBCU0fYuoEDxN97X014N5
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=680a3e77 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=Kr9SZwkY2YL0pQAKZLYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

Remove the caching of the CCA and EP11 card and domain info.
In nearly all places where the card or domain info is fetched
the verify param was enabled and thus the cache was bypassed.
The only real place where info from the cache was used was
in the sysfs pseudo files in cases where the card/queue was
switched to "offline". All other callers insisted on getting
fresh info and thus a communication to the card was enforced.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_cca.c        |  16 ++--
 drivers/s390/crypto/zcrypt_ccamisc.c  |  98 ++-------------------
 drivers/s390/crypto/zcrypt_ccamisc.h  |   8 +-
 drivers/s390/crypto/zcrypt_cex4.c     |  35 ++++----
 drivers/s390/crypto/zcrypt_ep11misc.c | 120 ++++----------------------
 drivers/s390/crypto/zcrypt_ep11misc.h |   2 +-
 6 files changed, 47 insertions(+), 232 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index cda22db31f6c..83b02a466346 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -109,7 +109,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 		}
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -128,7 +128,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 		}
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -173,7 +173,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			minhwtype = ZCRYPT_CEX6;
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -186,7 +186,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			old_mkvp = *((u64 *)alt_mkvp);
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -480,13 +480,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = t->bitsize;
 		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX3C, AES_MK_SET,
-				   t->mkvp, 0, 1);
+				   t->mkvp, 0);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
 			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX3C, AES_MK_SET,
-					   0, t->mkvp, 1);
+					   0, t->mkvp);
 			if (!rc)
 				*flags = PKEY_FLAGS_MATCH_ALT_MKVP;
 		}
@@ -513,13 +513,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			*keybitsize = PKEY_SIZE_AES_256;
 		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX6, AES_MK_SET,
-				   t->mkvp0, 0, 1);
+				   t->mkvp0, 0);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
 			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX6, AES_MK_SET,
-					   0, t->mkvp0, 1);
+					   0, t->mkvp0);
 			if (!rc)
 				*flags = PKEY_FLAGS_MATCH_ALT_MKVP;
 		}
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 2dc2aa32859e..1f4e14905ee5 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -30,17 +30,6 @@
 /* Size of vardata block used for some of the cca requests/replies */
 #define VARDATASIZE 4096
 
-struct cca_info_list_entry {
-	struct list_head list;
-	u16 cardnr;
-	u16 domain;
-	struct cca_info info;
-};
-
-/* a list with cca_info_list_entry entries */
-static LIST_HEAD(cca_info_list);
-static DEFINE_SPINLOCK(cca_info_list_lock);
-
 /*
  * Cprb memory pool held for urgent cases where no memory
  * can be allocated via kmalloc. This pool is only used
@@ -1633,69 +1622,11 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(cca_query_crypto_facility);
 
-static int cca_info_cache_fetch(u16 cardnr, u16 domain, struct cca_info *ci)
-{
-	int rc = -ENOENT;
-	struct cca_info_list_entry *ptr;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry(ptr, &cca_info_list, list) {
-		if (ptr->cardnr == cardnr && ptr->domain == domain) {
-			memcpy(ci, &ptr->info, sizeof(*ci));
-			rc = 0;
-			break;
-		}
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-
-	return rc;
-}
-
-static void cca_info_cache_update(u16 cardnr, u16 domain,
-				  const struct cca_info *ci)
-{
-	int found = 0;
-	struct cca_info_list_entry *ptr;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry(ptr, &cca_info_list, list) {
-		if (ptr->cardnr == cardnr &&
-		    ptr->domain == domain) {
-			memcpy(&ptr->info, ci, sizeof(*ci));
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		ptr = kmalloc(sizeof(*ptr), GFP_ATOMIC);
-		if (!ptr) {
-			spin_unlock_bh(&cca_info_list_lock);
-			return;
-		}
-		ptr->cardnr = cardnr;
-		ptr->domain = domain;
-		memcpy(&ptr->info, ci, sizeof(*ci));
-		list_add(&ptr->list, &cca_info_list);
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-}
-
-static void __exit mkvp_cache_free(void)
-{
-	struct cca_info_list_entry *ptr, *pnext;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry_safe(ptr, pnext, &cca_info_list, list) {
-		list_del(&ptr->list);
-		kfree(ptr);
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-}
-
 /*
- * Fetch cca_info values via query_crypto_facility from adapter.
+ * Fetch cca_info values about a CCA queue via
+ * query_crypto_facility from adapter.
  */
-static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
+int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
 {
 	int rc, found = 0;
 	size_t rlen, vlen;
@@ -1765,28 +1696,10 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 	free_page((unsigned long)pg);
 	return found == 2 ? 0 : -ENOENT;
 }
-
-/*
- * Fetch cca information about a CCA queue.
- */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
-{
-	int rc;
-
-	rc = cca_info_cache_fetch(card, dom, ci);
-	if (rc || verify) {
-		rc = fetch_cca_info(card, dom, ci);
-		if (rc == 0)
-			cca_info_cache_update(card, dom, ci);
-	}
-
-	return rc;
-}
 EXPORT_SYMBOL(cca_get_info);
 
 int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
-		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
-		  int verify)
+		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp)
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
@@ -1827,7 +1740,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		if (domain != 0xFFFF && dom != domain)
 			continue;
 		/* get cca info on this apqn */
-		if (cca_get_info(card, dom, &ci, verify))
+		if (cca_get_info(card, dom, &ci))
 			continue;
 		/* current master key needs to be valid */
 		if (mktype == AES_MK_SET && ci.cur_aes_mk_state != '2')
@@ -1900,7 +1813,6 @@ int __init zcrypt_ccamisc_init(void)
 
 void zcrypt_ccamisc_exit(void)
 {
-	mkvp_cache_free();
 	mutex_lock(&dev_status_mem_mutex);
 	kvfree(dev_status_mem);
 	mutex_unlock(&dev_status_mem_mutex);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 0662fe39e425..cc7d362a2bad 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -215,9 +215,6 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
  * - if minhwtype > 0 only apqns with hwtype >= minhwtype
  * - if cur_mkvp != 0 only apqns where cur_mkvp == mkvp
  * - if old_mkvp != 0 only apqns where old_mkvp == mkvp
- * - if verify is enabled and a cur_mkvp and/or old_mkvp
- *   value is given, then refetch the cca_info and make sure the current
- *   cur_mkvp or old_mkvp values of the apqn are used.
  * The mktype determines which set of master keys to use:
  *   0 = AES_MK_SET - AES MK set, 1 = APKA MK_SET - APKA MK set
  * The array of apqn entries is allocated with kmalloc and returned in *apqns;
@@ -228,8 +225,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
  * -ENODEV is returned.
  */
 int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
-		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
-		  int verify);
+		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp);
 
 #define AES_MK_SET  0
 #define APKA_MK_SET 1
@@ -261,7 +257,7 @@ struct cca_info {
 /*
  * Fetch cca information about an CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify);
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci);
 
 int zcrypt_ccamisc_init(void);
 void zcrypt_ccamisc_exit(void);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 64df7d2f6266..ecf1fcc6315e 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -79,14 +79,13 @@ static ssize_t cca_serialnr_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct cca_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct cca_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
 	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, zc->online);
+		cca_get_info(ac->id, ap_domain_index, &ci);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }
@@ -110,17 +109,17 @@ static ssize_t cca_mkvps_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
+	static const char * const new_state[] = { "empty", "partial", "full" };
+	static const char * const cao_state[] = { "invalid", "valid" };
 	struct zcrypt_queue *zq = dev_get_drvdata(dev);
-	int n = 0;
 	struct cca_info ci;
-	static const char * const cao_state[] = { "invalid", "valid" };
-	static const char * const new_state[] = { "empty", "partial", "full" };
+	int n = 0;
 
 	memset(&ci, 0, sizeof(ci));
 
 	cca_get_info(AP_QID_CARD(zq->queue->qid),
 		     AP_QID_QUEUE(zq->queue->qid),
-		     &ci, zq->online);
+		     &ci);
 
 	if (ci.new_aes_mk_state >= '1' && ci.new_aes_mk_state <= '3')
 		n += sysfs_emit_at(buf, n, "AES NEW: %s 0x%016llx\n",
@@ -210,13 +209,12 @@ static ssize_t ep11_api_ordinalnr_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	if (ci.API_ord_nr > 0)
 		return sysfs_emit(buf, "%u\n", ci.API_ord_nr);
@@ -231,13 +229,12 @@ static ssize_t ep11_fw_version_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	if (ci.FW_version > 0)
 		return sysfs_emit(buf, "%d.%d\n",
@@ -254,13 +251,12 @@ static ssize_t ep11_serialnr_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	if (ci.serial[0])
 		return sysfs_emit(buf, "%16.16s\n", ci.serial);
@@ -291,14 +287,13 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	int i, n = 0;
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
+	int i, n = 0;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (ci.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index df50b38dc7b9..c36802262415 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -55,86 +55,6 @@ static mempool_t *cprb_mempool;
 static void *dev_status_mem;
 static DEFINE_MUTEX(dev_status_mem_mutex);
 
-/* ep11 card info cache */
-struct card_list_entry {
-	struct list_head list;
-	u16 cardnr;
-	struct ep11_card_info info;
-};
-static LIST_HEAD(card_list);
-static DEFINE_SPINLOCK(card_list_lock);
-
-static int card_cache_fetch(u16 cardnr, struct ep11_card_info *ci)
-{
-	int rc = -ENOENT;
-	struct card_list_entry *ptr;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry(ptr, &card_list, list) {
-		if (ptr->cardnr == cardnr) {
-			memcpy(ci, &ptr->info, sizeof(*ci));
-			rc = 0;
-			break;
-		}
-	}
-	spin_unlock_bh(&card_list_lock);
-
-	return rc;
-}
-
-static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci)
-{
-	int found = 0;
-	struct card_list_entry *ptr;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry(ptr, &card_list, list) {
-		if (ptr->cardnr == cardnr) {
-			memcpy(&ptr->info, ci, sizeof(*ci));
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		ptr = kmalloc(sizeof(*ptr), GFP_ATOMIC);
-		if (!ptr) {
-			spin_unlock_bh(&card_list_lock);
-			return;
-		}
-		ptr->cardnr = cardnr;
-		memcpy(&ptr->info, ci, sizeof(*ci));
-		list_add(&ptr->list, &card_list);
-	}
-	spin_unlock_bh(&card_list_lock);
-}
-
-static void card_cache_scrub(u16 cardnr)
-{
-	struct card_list_entry *ptr;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry(ptr, &card_list, list) {
-		if (ptr->cardnr == cardnr) {
-			list_del(&ptr->list);
-			kfree(ptr);
-			break;
-		}
-	}
-	spin_unlock_bh(&card_list_lock);
-}
-
-static void __exit card_cache_free(void)
-{
-	struct card_list_entry *ptr, *pnext;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry_safe(ptr, pnext, &card_list, list) {
-		list_del(&ptr->list);
-		kfree(ptr);
-	}
-	spin_unlock_bh(&card_list_lock);
-}
-
 static int ep11_kb_split(const u8 *kb, size_t kblen, u32 kbver,
 			 struct ep11kblob_header **kbhdr, size_t *kbhdrsize,
 			 u8 **kbpl, size_t *kbplsize)
@@ -719,7 +639,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
+int ep11_get_card_info(u16 card, struct ep11_card_info *info)
 {
 	int rc;
 	struct ep11_module_query_info {
@@ -749,27 +669,20 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
 		u32 max_CP_index;
 	} __packed * pmqi = NULL;
 
-	rc = card_cache_fetch(card, info);
-	if (rc || verify) {
-		pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
-		if (!pmqi)
-			return -ENOMEM;
-		rc = ep11_query_info(card, AUTOSEL_DOM,
-				     0x01 /* module info query */,
-				     sizeof(*pmqi), (u8 *)pmqi);
-		if (rc) {
-			if (rc == -ENODEV)
-				card_cache_scrub(card);
-			goto out;
-		}
-		memset(info, 0, sizeof(*info));
-		info->API_ord_nr = pmqi->API_ord_nr;
-		info->FW_version =
-			(pmqi->FW_major_vers << 8) + pmqi->FW_minor_vers;
-		memcpy(info->serial, pmqi->serial, sizeof(info->serial));
-		info->op_mode = pmqi->op_mode;
-		card_cache_update(card, info);
-	}
+	pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
+	if (!pmqi)
+		return -ENOMEM;
+	rc = ep11_query_info(card, AUTOSEL_DOM,
+			     0x01 /* module info query */,
+			     sizeof(*pmqi), (u8 *)pmqi);
+	if (rc)
+		goto out;
+
+	memset(info, 0, sizeof(*info));
+	info->API_ord_nr = pmqi->API_ord_nr;
+	info->FW_version = (pmqi->FW_major_vers << 8) + pmqi->FW_minor_vers;
+	memcpy(info->serial, pmqi->serial, sizeof(info->serial));
+	info->op_mode = pmqi->op_mode;
 
 out:
 	kfree(pmqi);
@@ -1656,7 +1569,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 			continue;
 		/* check min api version if given */
 		if (minapi > 0) {
-			if (ep11_get_card_info(card, &eci, 0))
+			if (ep11_get_card_info(card, &eci))
 				continue;
 			if (minapi > eci.API_ord_nr)
 				continue;
@@ -1713,7 +1626,6 @@ int __init zcrypt_ep11misc_init(void)
 
 void zcrypt_ep11misc_exit(void)
 {
-	card_cache_free();
 	mutex_lock(&dev_status_mem_mutex);
 	kvfree(dev_status_mem);
 	mutex_unlock(&dev_status_mem_mutex);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index a4b98eca8431..dc1e418a6db1 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -104,7 +104,7 @@ struct ep11_domain_info {
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify);
+int ep11_get_card_info(u16 card, struct ep11_card_info *info);
 
 /*
  * Provide information about a domain within an EP11 card.
-- 
2.43.0



Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932E84BE334
	for <lists+linux-s390@lfdr.de>; Mon, 21 Feb 2022 18:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358556AbiBUNIV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Feb 2022 08:08:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358548AbiBUNIU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Feb 2022 08:08:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787491EC4F;
        Mon, 21 Feb 2022 05:07:55 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LC8gkW011808;
        Mon, 21 Feb 2022 13:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9wg2s4eWJfpmKWhtRpSZLpvQzrsyW5kDy9RuOgyWVVw=;
 b=abp/lRglFror++oLFT82t67urT5axz9ITx2pZmJ5QT3xSvpWfB86d6HAqku0XBPY78nl
 q3IrRmLzfDUchXFRhCVWOx5cAYhw0x+TsfZiDSxw9ugd8riU6loSvV6jmviRl5KyXt4h
 36zg3a82uvh2UUT0gJjCJhhjJEAAc2K3LYF8XGwwlETj/JvUuAJ4UaXSfP7cZs/pSUCW
 XZlhWI0a7IKbbZsyIwJvnFlj22TCdqb2QCpiHpeuCvVXduqclAEuaG9XNc8A9aQoBVk3
 akyW15GUZaZZSxuM2TIXg8911dGRRolu+BNbFtz8oJrXqBL/5e+hAvnl4Jf4liaMXlBl Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eby66wrrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:07:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21LCt1cm011314;
        Mon, 21 Feb 2022 13:07:54 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eby66wrqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:07:53 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21LCwvlp007314;
        Mon, 21 Feb 2022 13:07:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3ear68std0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:07:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21LD7mFw45351270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:07:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD1BA4C04A;
        Mon, 21 Feb 2022 13:07:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 729BE4C059;
        Mon, 21 Feb 2022 13:07:48 +0000 (GMT)
Received: from t46lp57.lnxne.boe (unknown [9.152.108.100])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 13:07:48 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com
Subject: [kvm-unit-tests PATCH v2 4/8] s390x: Add tests for STCRW
Date:   Mon, 21 Feb 2022 14:07:42 +0100
Message-Id: <20220221130746.1754410-5-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220221130746.1754410-1-nrb@linux.ibm.com>
References: <20220221130746.1754410-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sSIF9NBFgSnnT5NMGoo_nMAuPvzSOD09
X-Proofpoint-GUID: 9STb_ZVPZAoqG-FOaX-h5i5XNZfjGGJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_06,2022-02-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The test consists of two parts: First a simple check to ensure we
enforce an aligned address. We test misalignment by 1 and 2 bytes.

The second part tests the handling of pending Channel Reports (CR). We
first assume no CR is initally pending and check STCRW returns
accordingly. Then, we generate a CR by resetting a Channel Path using
RCHP and make sure this results in exactly one CRW being generated which
has a Reporting-Source Code (RSC) corresponding to the Channel Path
facility.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/css.h     | 17 ++++++++++
 lib/s390x/css_lib.c | 60 +++++++++++++++++++++++++++++++++
 s390x/css.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)

diff --git a/lib/s390x/css.h b/lib/s390x/css.h
index 0db8a28166f6..a6a68577248b 100644
--- a/lib/s390x/css.h
+++ b/lib/s390x/css.h
@@ -266,6 +266,20 @@ static inline int rchp(unsigned long chpid)
 	return cc;
 }
 
+static inline int stcrw(uint32_t *crw)
+{
+	int cc;
+
+	asm volatile(
+		"	stcrw	%[crw]\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28"
+		: [cc] "=d" (cc)
+		: [crw] "Q" (*crw)
+		: "cc", "memory");
+	return cc;
+}
+
 /* Debug functions */
 char *dump_pmcw_flags(uint16_t f);
 char *dump_scsw_flags(uint32_t f);
@@ -294,6 +308,9 @@ int css_residual_count(unsigned int schid);
 void enable_io_isc(uint8_t isc);
 int wait_and_check_io_completion(int schid);
 
+int css_find_installed_chpid(int sid, uint8_t *chpid_out);
+int css_generate_crw(int sid);
+
 /*
  * CHSC definitions
  */
diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
index 80e9e078b0f6..a9f5097f3486 100644
--- a/lib/s390x/css_lib.c
+++ b/lib/s390x/css_lib.c
@@ -504,3 +504,63 @@ void enable_io_isc(uint8_t isc)
 	value = (uint64_t)isc << 24;
 	lctlg(6, value);
 }
+
+static int is_path_installed(struct schib *schib, int chp_idx)
+{
+	return schib->pmcw.pim & BIT(7 - chp_idx);
+}
+
+/*
+ * css_find_installed_chpid: find any installed CHPID
+ * @sid: subsystem-identification word
+ * @chpid_out: store the found chpid here, left alone if none found
+ *
+ * returns 0 on success, -1 if no chpid found any other value
+ * indicates the condition code of a failing STSCH instruction
+ */
+int css_find_installed_chpid(int sid, uint8_t *chpid_out)
+{
+	int cc;
+
+	cc = stsch(sid, &schib);
+	if (cc) {
+		report_fail("%s: sch %08x failed with cc=%d", __func__, sid, cc);
+		return cc;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(schib.pmcw.chpid); i++) {
+		if (is_path_installed(&schib, i)) {
+			*chpid_out = schib.pmcw.chpid[i];
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+/*
+ * css_generate_crw: Generate a CRW by issuing RCHP on any channel path
+ * @sid: subsystem-identification word
+ *
+ * returns 0 when a CRW was generated, -1 if no chpid found.
+ */
+int css_generate_crw(int sid)
+{
+	int ret, cc;
+	uint8_t chpid;
+
+	report_prefix_push("Generate CRW");
+
+	ret = css_find_installed_chpid(sid, &chpid);
+	if (ret) {
+		report_fail("No CHPID found: ret=%d", ret);
+		return -1;
+	}
+
+	cc = rchp(chpid);
+	report(!cc, "rhcp cc != 0");
+
+	report_prefix_pop();
+
+	return 0;
+}
diff --git a/s390x/css.c b/s390x/css.c
index 932daf69bb36..6a2db79c8097 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -383,6 +383,87 @@ static void test_msch(void)
 	schib.pmcw.flags = old_pmcw_flags;
 }
 
+static void check_stcrw_no_crw_available(void)
+{
+	uint32_t crw = 0xfeedc0fe;
+	int cc;
+
+	report_prefix_push("No CRW available");
+	cc = stcrw(&crw);
+	report(cc == 1, "cc == 1");
+	report(!crw, "stored zeroes in crw");
+	report_prefix_pop();
+}
+
+static int check_stcrw_crw_available(void)
+{
+	const uint32_t magic = 0xfeedc0fe;
+	uint32_t crw = magic;
+	int cc;
+
+	report_prefix_push("CRW available");
+	cc = stcrw(&crw);
+	report(!cc, "cc is zero");
+	report(crw != magic, "stored crw");
+	report_prefix_pop();
+
+	return crw;
+}
+
+static uint32_t crw_get_rsc(uint32_t crw)
+{
+	const int rsc_begin = 4;
+	const int rsc_end = 8;
+
+	return (crw & GENMASK(31 - rsc_begin, 31 - rsc_end)) >> 24;
+}
+
+#define CRW_RSC_CHP 4
+static void test_stcrw(void)
+{
+	const int align_to = 4;
+	int res;
+	uint32_t crw;
+
+	if (!test_device_sid) {
+		report_skip("No device");
+		return;
+	}
+
+	report_prefix_push("Unaligned");
+	for (int i = 1; i < align_to; i *= 2) {
+		report_prefix_pushf("%d", i);
+
+		expect_pgm_int();
+		stcrw((uint32_t *)(alignment_test_page + i));
+		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+
+		report_prefix_pop();
+	}
+	report_prefix_pop();
+
+	report_prefix_push("No CRW available initally");
+	check_stcrw_no_crw_available();
+	report_prefix_pop();
+
+	res = css_generate_crw(test_device_sid);
+	if (res) {
+		report_skip("Couldn't generate CRW");
+		report_prefix_pop();
+		return;
+	}
+
+	crw = check_stcrw_crw_available();
+
+	report_prefix_push("CRW available");
+	report(crw_get_rsc(crw) == CRW_RSC_CHP, "CRW has Channel Path RSC");
+	report_prefix_pop();
+
+	report_prefix_push("No more CRWs pending");
+	check_stcrw_no_crw_available();
+	report_prefix_pop();
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
@@ -396,6 +477,7 @@ static struct {
 	{ "measurement block format0", test_schm_fmt0 },
 	{ "measurement block format1", test_schm_fmt1 },
 	{ "msch", test_msch },
+	{ "stcrw", test_stcrw },
 	{ NULL, NULL }
 };
 
-- 
2.31.1


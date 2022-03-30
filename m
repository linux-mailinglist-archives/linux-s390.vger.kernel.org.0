Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733F4EC6F2
	for <lists+linux-s390@lfdr.de>; Wed, 30 Mar 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbiC3OqE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 30 Mar 2022 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347161AbiC3Opq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Mar 2022 10:45:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E97004D;
        Wed, 30 Mar 2022 07:43:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UE1i8R011625;
        Wed, 30 Mar 2022 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8gPUcPbuK37DvQspWI7NU0gD2o14JU2zpU82KgAfRsI=;
 b=opTAJozv8s5pOM8tSplAH2qq/UrDcFbQY6ivOtxJKyT5v11DtsK0DoA4meVi3QwraH8U
 6CJyCPWR1toGiGp3yORzEbiC+T3nvuUkDvQi68xz75iZFO94kE3U5ipTplUKCr09mH/B
 yWu2ps7nx/WFMXT3mSTtP4ftOgUHb53I2vcq7tCLvuQ7Le0kEHpjqQ4AVNIi27GiDMg0
 wlG+ZbniQJRWRIENQTMnUKtyl+3SMHUwXl+60luDzSMP4kSLQl15EUqDs0cPkcaY0tLh
 9vMb0gNeURyIsHFpy4/B+5xumPfRjmO9H56zCm4ovBTBYiiwHRRQCyHMcWE9IvBnUlhi zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40c98n4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 14:43:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UEWBQn025929;
        Wed, 30 Mar 2022 14:43:55 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40c98n4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 14:43:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UEcmbE015456;
        Wed, 30 Mar 2022 14:43:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3f1tf8qgc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 14:43:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UEhoBX16122268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 14:43:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 051184C04A;
        Wed, 30 Mar 2022 14:43:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A3E4C040;
        Wed, 30 Mar 2022 14:43:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.13.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Mar 2022 14:43:49 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        scgl@linux.ibm.com, borntraeger@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, nrb@linux.ibm.com, thuth@redhat.com,
        david@redhat.com
Subject: [kvm-unit-tests PATCH v1 3/4] lib: s390x: functions for machine models
Date:   Wed, 30 Mar 2022 16:43:38 +0200
Message-Id: <20220330144339.261419-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330144339.261419-1-imbrenda@linux.ibm.com>
References: <20220330144339.261419-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A2YhIDOH8iv5iBJ5lvJ5atjMvGRp-iXk
X-Proofpoint-GUID: 2X3waP30sPGIsvM_afCMCkUAYOWT5Q3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_04,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=641 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

* move existing macros for machine models to hardware.h
* add macros for all known machine models
* add machine_is_* functions
---
 lib/s390x/asm/arch_def.h |  3 --
 lib/s390x/hardware.h     | 82 ++++++++++++++++++++++++++++++++++++++++
 s390x/uv-host.c          |  4 +-
 3 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 40626d72..8d860ccf 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -219,9 +219,6 @@ static inline unsigned short stap(void)
 	return cpu_address;
 }
 
-#define MACHINE_Z15A	0x8561
-#define MACHINE_Z15B	0x8562
-
 static inline uint16_t get_machine_id(void)
 {
 	uint64_t cpuid;
diff --git a/lib/s390x/hardware.h b/lib/s390x/hardware.h
index 93f817ca..fb6565ad 100644
--- a/lib/s390x/hardware.h
+++ b/lib/s390x/hardware.h
@@ -13,6 +13,25 @@
 #define _S390X_HARDWARE_H_
 #include <asm/arch_def.h>
 
+#define MACHINE_Z900	0x2064
+#define MACHINE_Z800	0x2066
+#define MACHINE_Z990	0x2084
+#define MACHINE_Z890	0x2086
+#define MACHINE_Z9EC	0x2094
+#define MACHINE_Z9BC	0x2096
+#define MACHINE_Z10EC	0x2097
+#define MACHINE_Z10BC	0x2098
+#define MACHINE_Z196	0x2817
+#define MACHINE_Z114	0x2818
+#define MACHINE_ZEC12	0x2827
+#define MACHINE_ZBC12	0x2828
+#define MACHINE_Z13	0x2964
+#define MACHINE_Z13S	0x2965
+#define MACHINE_Z14	0x3906
+#define MACHINE_Z14ZR1	0x3907
+#define MACHINE_Z15	0x8561
+#define MACHINE_Z15T02	0x8562
+
 enum s390_host {
 	HOST_IS_UNKNOWN,
 	HOST_IS_LPAR,
@@ -44,4 +63,67 @@ static inline bool host_is_zvm6(void)
 	return detect_host() == HOST_IS_ZVM6;
 }
 
+static inline bool machine_is_z900(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z900 || machine == MACHINE_Z800;
+}
+
+static inline bool machine_is_z990(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z990 || machine == MACHINE_Z890;
+}
+
+static inline bool machine_is_z9(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z9EC || machine == MACHINE_Z9BC;
+}
+
+static inline bool machine_is_z10(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z10EC || machine == MACHINE_Z10BC;
+}
+
+static inline bool machine_is_z1xx(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z196 || machine == MACHINE_Z114;
+}
+
+static inline bool machine_is_z12(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_ZEC12 || machine == MACHINE_ZBC12;
+}
+
+static inline bool machine_is_z13(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z13 || machine == MACHINE_Z13S;
+}
+
+static inline bool machine_is_z14(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z14 || machine == MACHINE_Z14ZR1;
+}
+
+static inline bool machine_is_z15(void)
+{
+	uint16_t machine = get_machine_id();
+
+	return machine == MACHINE_Z15 || machine == MACHINE_Z15T02;
+}
+
 #endif  /* _S390X_HARDWARE_H_ */
diff --git a/s390x/uv-host.c b/s390x/uv-host.c
index de2e4850..d3018e3c 100644
--- a/s390x/uv-host.c
+++ b/s390x/uv-host.c
@@ -9,6 +9,7 @@
  */
 
 #include <libcflat.h>
+#include <hardware.h>
 #include <alloc.h>
 #include <vmalloc.h>
 #include <sclp.h>
@@ -111,7 +112,6 @@ static void test_config_destroy(void)
 static void test_cpu_destroy(void)
 {
 	int rc;
-	uint16_t machineid = get_machine_id();
 	struct uv_cb_nodata uvcb = {
 		.header.len = sizeof(uvcb),
 		.header.cmd = UVC_CMD_DESTROY_SEC_CPU,
@@ -126,7 +126,7 @@ static void test_cpu_destroy(void)
 	       "hdr invalid length");
 	uvcb.header.len += 8;
 
-	if (machineid != MACHINE_Z15A && machineid != MACHINE_Z15B) {
+	if (!machine_is_z15()) {
 		uvcb.handle += 1;
 		rc = uv_call(0, (uint64_t)&uvcb);
 		report(rc == 1 && uvcb.header.rc == UVC_RC_INV_CHANDLE, "invalid handle");
-- 
2.34.1


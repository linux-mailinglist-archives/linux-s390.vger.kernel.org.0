Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706D667A03
	for <lists+linux-s390@lfdr.de>; Thu, 12 Jan 2023 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjALP5W (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Jan 2023 10:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjALP4c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Jan 2023 10:56:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FDCF3;
        Thu, 12 Jan 2023 07:46:43 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFMi0W007486;
        Thu, 12 Jan 2023 15:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FymxuNJ0TKR8x2t9YRt0aljKT6E83V80FCzzVLfyHYA=;
 b=JDM/+1dgnWcSft66esu/ymY1EKG47wHBJ/xA25V28ZzWskKJ9bs6421sjNC8ISlhgWga
 sz/msk52tDNCBbarv7DQ0FLlhJ1o70YqXu1F5lpuIByKHWeWQ7SWvIij60pe/frusMBA
 NrOQVYCrSCFfhcmWaiet9aaqQObD+Mh3r3DW+fok/fWKSGgS5zPOUo+DkS9KLt2Dua8m
 0+Xh0KcOhmcOSuaoxdrFxiRg031PtJTh5ewVN3NGmxQOHX4IxtioQkKZJw8eU90wU7W1
 3PyG5q9K3FCUUwt2y3CgoTuDX7NIJ9TZvCUpMuaY/NVTBDM2Ucm1qJIy3WKnUb3Qz8iE ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2msmgqd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:46:42 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CFPOVA015365;
        Thu, 12 Jan 2023 15:46:41 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2msmgqcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:46:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFMRWe030858;
        Thu, 12 Jan 2023 15:46:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n1kf7jprh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:46:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CFkaIe23658988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 15:46:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 501B52004B;
        Thu, 12 Jan 2023 15:46:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B14820049;
        Thu, 12 Jan 2023 15:46:36 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 15:46:36 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, david@redhat.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v2 3/7] s390x: Add a linker script to assembly snippets
Date:   Thu, 12 Jan 2023 15:45:44 +0000
Message-Id: <20230112154548.163021-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112154548.163021-1-frankja@linux.ibm.com>
References: <20230112154548.163021-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3UkvUpH6VqIWiNMO3FDwOICAq064bH4r
X-Proofpoint-ORIG-GUID: 4aL5t40ysSw1doeZfAd5zV6gpDXBXsUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A linker script has a few benefits:
- Random data doesn't end up in the binary breaking tests
- We can easily define a lowcore and load the snippet from 0x0 instead
of 0x4000 which makes asm snippets behave like c snippets
- We can easily define an invalid PGM new PSW to ensure an exit on a
guest PGM

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/snippet.h         |  3 +--
 s390x/Makefile              |  5 +++--
 s390x/mvpg-sie.c            |  2 +-
 s390x/pv-diags.c            |  6 +++---
 s390x/snippets/asm/flat.lds | 41 +++++++++++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 8 deletions(-)
 create mode 100644 s390x/snippets/asm/flat.lds

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index b17b2a4c..57045994 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -32,8 +32,7 @@
 
 #define SNIPPET_PV_TWEAK0	0x42UL
 #define SNIPPET_PV_TWEAK1	0UL
-#define SNIPPET_OFF_C		0
-#define SNIPPET_OFF_ASM		0x4000
+#define SNIPPET_UNPACK_OFF	0
 
 
 /*
diff --git a/s390x/Makefile b/s390x/Makefile
index 52a9d821..97a61611 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -136,7 +136,8 @@ $(SNIPPET_DIR)/c/%.o: $(SNIPPET_DIR)/c/%.c $(asm-offsets)
 	$(CC) $(CFLAGS) -c -nostdlib -o $@ $<
 
 $(SNIPPET_DIR)/asm/%.gbin: $(SNIPPET_DIR)/asm/%.o
-	$(OBJCOPY) -O binary -j ".rodata" -j ".text" -j ".data" -j ".bss" --set-section-flags .bss=alloc,load,contents $(patsubst %.gbin,%.o,$@) $@
+	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/snippets/asm/flat.lds $<
+	$(OBJCOPY) -O binary -j ".rodata" -j ".lowcore" -j ".text" -j ".data" -j ".bss" --set-section-flags .bss=alloc,load,contents $@ $@
 	truncate -s '%4096' $@
 
 $(SNIPPET_DIR)/c/%.gbin: $(SNIPPET_DIR)/c/%.o $(snippet_lib) $(FLATLIBS)
@@ -145,7 +146,7 @@ $(SNIPPET_DIR)/c/%.gbin: $(SNIPPET_DIR)/c/%.o $(snippet_lib) $(FLATLIBS)
 	truncate -s '%4096' $@
 
 $(SNIPPET_DIR)/asm/%.hdr: $(SNIPPET_DIR)/asm/%.gbin $(HOST_KEY_DOCUMENT)
-	$(GEN_SE_HEADER) -k $(HOST_KEY_DOCUMENT) -c $<,0x4000,0x00000000000000420000000000000000 --psw-addr 0x4000 -o $@
+	$(GEN_SE_HEADER) -k $(HOST_KEY_DOCUMENT) -c $<,0x0,0x00000000000000420000000000000000 --psw-addr 0x4000 -o $@
 
 $(SNIPPET_DIR)/c/%.hdr: $(SNIPPET_DIR)/c/%.gbin $(HOST_KEY_DOCUMENT)
 	$(GEN_SE_HEADER) -k $(HOST_KEY_DOCUMENT) -c $<,0x0,0x00000000000000420000000000000000 --psw-addr 0x4000 -o $@
diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
index 46a2edb6..99f4859b 100644
--- a/s390x/mvpg-sie.c
+++ b/s390x/mvpg-sie.c
@@ -87,7 +87,7 @@ static void setup_guest(void)
 
 	snippet_setup_guest(&vm, false);
 	snippet_init(&vm, SNIPPET_NAME_START(c, mvpg_snippet),
-		     SNIPPET_LEN(c, mvpg_snippet), SNIPPET_OFF_C);
+		     SNIPPET_LEN(c, mvpg_snippet), SNIPPET_UNPACK_OFF);
 
 	/* Enable MVPG interpretation as we want to test KVM and not ourselves */
 	vm.sblk->eca = ECA_MVPGI;
diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
index 9ced68c7..5165937a 100644
--- a/s390x/pv-diags.c
+++ b/s390x/pv-diags.c
@@ -28,7 +28,7 @@ static void test_diag_500(void)
 
 	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, snippet_pv_diag_500),
 			SNIPPET_HDR_START(asm, snippet_pv_diag_500),
-			size_gbin, size_hdr, SNIPPET_OFF_ASM);
+			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
 
 	sie(&vm);
 	report(vm.sblk->icptcode == ICPT_PV_INSTR && vm.sblk->ipa == 0x8302 &&
@@ -83,7 +83,7 @@ static void test_diag_288(void)
 
 	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, snippet_pv_diag_288),
 			SNIPPET_HDR_START(asm, snippet_pv_diag_288),
-			size_gbin, size_hdr, SNIPPET_OFF_ASM);
+			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
 
 	sie(&vm);
 	report(vm.sblk->icptcode == ICPT_PV_INSTR && vm.sblk->ipa == 0x8302 &&
@@ -124,7 +124,7 @@ static void test_diag_yield(void)
 
 	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, snippet_pv_diag_yield),
 			SNIPPET_HDR_START(asm, snippet_pv_diag_yield),
-			size_gbin, size_hdr, SNIPPET_OFF_ASM);
+			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
 
 	/* 0x44 */
 	report_prefix_push("0x44");
diff --git a/s390x/snippets/asm/flat.lds b/s390x/snippets/asm/flat.lds
new file mode 100644
index 00000000..ab0031ac
--- /dev/null
+++ b/s390x/snippets/asm/flat.lds
@@ -0,0 +1,41 @@
+SECTIONS
+{
+	.lowcore : {
+		/*
+		 * Initial short psw for disk boot, with 31 bit addressing for
+		 * non z/Arch environment compatibility and the instruction
+		 * address 0x4000.
+		 */
+		. = 0;
+		 LONG(0x00080000)
+		 LONG(0x80004000)
+		 /* Restart new PSW for booting via PSW restart. */
+		 . = 0x1a0;
+		 QUAD(0x0000000180000000)
+		 QUAD(0x0000000000004000)
+		 /*
+		  * Invalid PGM new PSW so we hopefully get a code 8
+		  * intercept on a PGM
+		  */
+		 . = 0x1d0;
+		 QUAD(0x0008000000000000)
+		 QUAD(0x0000000000000001)
+	}
+	. = 0x4000;
+	/* Start text 0x4000 */
+	.text : {
+		*(.text)
+		*(.text.*)
+	}
+	. = ALIGN(16);
+	etext = .;
+	/* End text */
+	/* Start data */
+	.data : {
+		*(.data)
+		*(.data.rel*)
+	}
+	. = ALIGN(16);
+	.rodata : { *(.rodata) *(.rodata.*) }
+	/* End data */
+}
-- 
2.34.1


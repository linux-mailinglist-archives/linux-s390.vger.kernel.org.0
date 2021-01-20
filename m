Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23A2FD01A
	for <lists+linux-s390@lfdr.de>; Wed, 20 Jan 2021 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbhATMZn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Jan 2021 07:25:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388476AbhATLoY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 06:44:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KBaW0M021261;
        Wed, 20 Jan 2021 06:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g1pvDvT19xTXBJPYGnJLy+a2qcVJkgIHy/PWKdDO0tI=;
 b=EXPNpTe4KNyAqs17it7fvmp51N0rQ57oRVhFd0NTxQTrMd84GdRrfaRawsvnfB2EshUq
 bQnahgTm0KGYVrYkeZJMRNDqC5PiTAQavmpfB3t+lCAeqdXeN4xUzkmvkFrrHnQgFhXY
 yH+/Y1O0WLXI4EVNBNhXf4PAG/pnkfqXLZIDBpfvOccgHEjJoVritaXEPoxFzClvEARQ
 qErXmSU4BadGTe60SHTMeN9M490Cd2575CAVNuDved4hS9zeF8x6vhyqG0KtdieV9SQA
 CvtXERe1PD7k/Of+6t/sMU/M5/qzk9iINEda90P2XIRpKLQRGS5lTV01dcEKA4CldFw7 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 366jnb24ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 06:43:42 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10KBaZgK021501;
        Wed, 20 Jan 2021 06:43:42 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 366jnb24uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 06:43:42 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KBfVr9013643;
        Wed, 20 Jan 2021 11:43:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3668parhck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 11:43:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KBhcOI45613566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 11:43:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B72AE057;
        Wed, 20 Jan 2021 11:43:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A8F4AE051;
        Wed, 20 Jan 2021 11:43:37 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 11:43:36 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Subject: [kvm-unit-tests GIT PULL 10/11] s390x: Fix sclp.h style issues
Date:   Wed, 20 Jan 2021 06:41:57 -0500
Message-Id: <20210120114158.104559-11-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120114158.104559-1-frankja@linux.ibm.com>
References: <20210120114158.104559-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_02:2021-01-18,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200064
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix indentation

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/sclp.h | 172 +++++++++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index e7407ea..9f81c0f 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -79,10 +79,10 @@
 #define SCCB_SIZE 4096
 
 typedef struct SCCBHeader {
-    uint16_t length;
-    uint8_t function_code;
-    uint8_t control_mask[3];
-    uint16_t response_code;
+	uint16_t length;
+	uint8_t function_code;
+	uint8_t control_mask[3];
+	uint16_t response_code;
 } __attribute__((packed)) SCCBHeader;
 
 #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
@@ -90,15 +90,15 @@ typedef struct SCCBHeader {
 
 /* CPU information */
 typedef struct CPUEntry {
-    uint8_t address;
-    uint8_t reserved0;
-    uint8_t : 4;
-    uint8_t feat_sief2 : 1;
-    uint8_t : 3;
-    uint8_t features_res2 [SCCB_CPU_FEATURE_LEN - 1];
-    uint8_t reserved2[6];
-    uint8_t type;
-    uint8_t reserved1;
+	uint8_t address;
+	uint8_t reserved0;
+	uint8_t : 4;
+	uint8_t feat_sief2 : 1;
+	uint8_t : 3;
+	uint8_t features_res2 [SCCB_CPU_FEATURE_LEN - 1];
+	uint8_t reserved2[6];
+	uint8_t type;
+	uint8_t reserved1;
 } __attribute__((packed)) CPUEntry;
 
 extern struct sclp_facilities sclp_facilities;
@@ -110,77 +110,77 @@ struct sclp_facilities {
 };
 
 typedef struct ReadInfo {
-    SCCBHeader h;
-    uint16_t rnmax;
-    uint8_t rnsize;
-    uint8_t  _reserved1[16 - 11];       /* 11-15 */
-    uint16_t entries_cpu;               /* 16-17 */
-    uint16_t offset_cpu;                /* 18-19 */
-    uint8_t  _reserved2[24 - 20];       /* 20-23 */
-    uint8_t  loadparm[8];               /* 24-31 */
-    uint8_t  _reserved3[48 - 32];       /* 32-47 */
-    uint64_t facilities;                /* 48-55 */
-    uint8_t  _reserved0[76 - 56];       /* 56-75 */
-    uint32_t ibc_val;
-    uint8_t  conf_char[99 - 80];        /* 80-98 */
-    uint8_t mha_pow;
-    uint32_t rnsize2;
-    uint64_t rnmax2;
-    uint8_t  _reserved6[116 - 112];     /* 112-115 */
-    uint8_t  conf_char_ext[120 - 116];   /* 116-119 */
-    uint16_t highest_cpu;
-    uint8_t  _reserved5[124 - 122];     /* 122-123 */
-    uint32_t hmfai;
-    uint8_t reserved7[134 - 128];
-    uint8_t byte_134_diag318 : 1;
-    uint8_t : 7;
-    struct CPUEntry entries[0];
+	SCCBHeader h;
+	uint16_t rnmax;
+	uint8_t rnsize;
+	uint8_t  _reserved1[16 - 11];       /* 11-15 */
+	uint16_t entries_cpu;               /* 16-17 */
+	uint16_t offset_cpu;                /* 18-19 */
+	uint8_t  _reserved2[24 - 20];       /* 20-23 */
+	uint8_t  loadparm[8];               /* 24-31 */
+	uint8_t  _reserved3[48 - 32];       /* 32-47 */
+	uint64_t facilities;                /* 48-55 */
+	uint8_t  _reserved0[76 - 56];       /* 56-75 */
+	uint32_t ibc_val;
+	uint8_t  conf_char[99 - 80];        /* 80-98 */
+	uint8_t mha_pow;
+	uint32_t rnsize2;
+	uint64_t rnmax2;
+	uint8_t  _reserved6[116 - 112];     /* 112-115 */
+	uint8_t  conf_char_ext[120 - 116];   /* 116-119 */
+	uint16_t highest_cpu;
+	uint8_t  _reserved5[124 - 122];     /* 122-123 */
+	uint32_t hmfai;
+	uint8_t reserved7[134 - 128];
+	uint8_t byte_134_diag318 : 1;
+	uint8_t : 7;
+	struct CPUEntry entries[0];
 } __attribute__((packed)) ReadInfo;
 
 typedef struct ReadCpuInfo {
-    SCCBHeader h;
-    uint16_t nr_configured;         /* 8-9 */
-    uint16_t offset_configured;     /* 10-11 */
-    uint16_t nr_standby;            /* 12-13 */
-    uint16_t offset_standby;        /* 14-15 */
-    uint8_t reserved0[24-16];       /* 16-23 */
-    struct CPUEntry entries[0];
+	SCCBHeader h;
+	uint16_t nr_configured;         /* 8-9 */
+	uint16_t offset_configured;     /* 10-11 */
+	uint16_t nr_standby;            /* 12-13 */
+	uint16_t offset_standby;        /* 14-15 */
+	uint8_t reserved0[24-16];       /* 16-23 */
+	struct CPUEntry entries[0];
 } __attribute__((packed)) ReadCpuInfo;
 
 typedef struct ReadStorageElementInfo {
-    SCCBHeader h;
-    uint16_t max_id;
-    uint16_t assigned;
-    uint16_t standby;
-    uint8_t _reserved0[16 - 14]; /* 14-15 */
-    uint32_t entries[0];
+	SCCBHeader h;
+	uint16_t max_id;
+	uint16_t assigned;
+	uint16_t standby;
+	uint8_t _reserved0[16 - 14]; /* 14-15 */
+	uint32_t entries[0];
 } __attribute__((packed)) ReadStorageElementInfo;
 
 typedef struct AttachStorageElement {
-    SCCBHeader h;
-    uint8_t _reserved0[10 - 8];  /* 8-9 */
-    uint16_t assigned;
-    uint8_t _reserved1[16 - 12]; /* 12-15 */
-    uint32_t entries[0];
+	SCCBHeader h;
+	uint8_t _reserved0[10 - 8];  /* 8-9 */
+	uint16_t assigned;
+	uint8_t _reserved1[16 - 12]; /* 12-15 */
+	uint32_t entries[0];
 } __attribute__((packed)) AttachStorageElement;
 
 typedef struct AssignStorage {
-    SCCBHeader h;
-    uint16_t rn;
+	SCCBHeader h;
+	uint16_t rn;
 } __attribute__((packed)) AssignStorage;
 
 typedef struct IoaCfgSccb {
-    SCCBHeader header;
-    uint8_t atype;
-    uint8_t reserved1;
-    uint16_t reserved2;
-    uint32_t aid;
+	SCCBHeader header;
+	uint8_t atype;
+	uint8_t reserved1;
+	uint16_t reserved2;
+	uint32_t aid;
 } __attribute__((packed)) IoaCfgSccb;
 
 typedef struct SCCB {
-    SCCBHeader h;
-    char data[SCCB_DATA_LEN];
- } __attribute__((packed)) SCCB;
+	SCCBHeader h;
+	char data[SCCB_DATA_LEN];
+} __attribute__((packed)) SCCB;
 
 /* SCLP event types */
 #define SCLP_EVENT_ASCII_CONSOLE_DATA           0x1a
@@ -195,13 +195,13 @@ typedef struct SCCB {
 #define SCLP_SELECTIVE_READ                     0x01
 
 typedef struct WriteEventMask {
-    SCCBHeader h;
-    uint16_t _reserved;
-    uint16_t mask_length;
-    uint32_t cp_receive_mask;
-    uint32_t cp_send_mask;
-    uint32_t send_mask;
-    uint32_t receive_mask;
+	SCCBHeader h;
+	uint16_t _reserved;
+	uint16_t mask_length;
+	uint32_t cp_receive_mask;
+	uint32_t cp_send_mask;
+	uint32_t send_mask;
+	uint32_t receive_mask;
 } __attribute__((packed)) WriteEventMask;
 
 #define MDBTYP_GO               0x0001
@@ -254,25 +254,25 @@ struct mdb {
 } __attribute__((packed));
 
 typedef struct EventBufferHeader {
-    uint16_t length;
-    uint8_t  type;
-    uint8_t  flags;
-    uint16_t _reserved;
+	uint16_t length;
+	uint8_t  type;
+	uint8_t  flags;
+	uint16_t _reserved;
 } __attribute__((packed)) EventBufferHeader;
 
 typedef struct WriteEventData {
-    SCCBHeader h;
-    EventBufferHeader ebh;
-    union {
-	char data[0];
-	struct mdb mdb;
-    } msg;
+	SCCBHeader h;
+	EventBufferHeader ebh;
+	union {
+		char data[0];
+		struct mdb mdb;
+	} msg;
 } __attribute__((packed)) WriteEventData;
 
 typedef struct ReadEventData {
-    SCCBHeader h;
-    EventBufferHeader ebh;
-    uint32_t mask;
+	SCCBHeader h;
+	EventBufferHeader ebh;
+	uint32_t mask;
 } __attribute__((packed)) ReadEventData;
 
 extern char _sccb[];
-- 
2.25.1


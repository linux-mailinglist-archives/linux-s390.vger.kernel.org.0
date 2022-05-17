Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3B52A830
	for <lists+linux-s390@lfdr.de>; Tue, 17 May 2022 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350991AbiEQQhF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 May 2022 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351012AbiEQQhA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 May 2022 12:37:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFFF3135C;
        Tue, 17 May 2022 09:36:58 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HGXOlj013019;
        Tue, 17 May 2022 16:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FLgDzTMz+Q/+m2hKKv2PkyBboV04PyHJuJYreacnZ8g=;
 b=IfI8KT6jsaQz0hhNDRBazrrn0iEUCpmU/w4pujcoMwOK9LoMRL8sS9iNoIURdTLI3o2T
 h2QILZOHvHLQ9Igu/TEXPrfVB6lcKuLec749PtscgpC1hbp9hthWOVS5fD49uIyq3VaW
 gL98lDYSmD7I9vTpHgjqS7RWSP3cHN003MNR35NgxSMF2t+S9HlDUqWodPmaB7JdQgm3
 yfflmxwdUgTOpqDBj8/UF1S4v8HZ3mdLJF2kGE5VKwHureUPT+Zxcgg7LQUQxq9WWvns
 tPzZEaPLKtFOUMPpIhwTcILRVq4koVINkRsOcWieEnTp/ztvzew87y3eK6GYsScPL+GX Qw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4fb3045u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 16:36:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HGXfgs031825;
        Tue, 17 May 2022 16:36:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429chmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 16:36:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HGN2jV54919500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 16:23:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9D5F11C04C;
        Tue, 17 May 2022 16:36:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D80411C04A;
        Tue, 17 May 2022 16:36:52 +0000 (GMT)
Received: from linux6.. (unknown [9.114.12.104])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 16:36:52 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v6 09/11] Documentation: virt: Protected virtual machine dumps
Date:   Tue, 17 May 2022 16:36:27 +0000
Message-Id: <20220517163629.3443-10-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220517163629.3443-1-frankja@linux.ibm.com>
References: <20220517163629.3443-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hyUKXv0lljhp3R_yS7t9berrHoM8G08N
X-Proofpoint-GUID: hyUKXv0lljhp3R_yS7t9berrHoM8G08N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's add a documentation file which describes the dump process. Since
we only copy the UV dump data from the UV to userspace we'll not go
into detail here and let the party which processes the data describe
its structure.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/s390/index.rst        |  1 +
 Documentation/virt/kvm/s390/s390-pv-dump.rst | 64 ++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/virt/kvm/s390/s390-pv-dump.rst

diff --git a/Documentation/virt/kvm/s390/index.rst b/Documentation/virt/kvm/s390/index.rst
index 605f488f0cc5..44ec9ab14b59 100644
--- a/Documentation/virt/kvm/s390/index.rst
+++ b/Documentation/virt/kvm/s390/index.rst
@@ -10,3 +10,4 @@ KVM for s390 systems
    s390-diag
    s390-pv
    s390-pv-boot
+   s390-pv-dump
diff --git a/Documentation/virt/kvm/s390/s390-pv-dump.rst b/Documentation/virt/kvm/s390/s390-pv-dump.rst
new file mode 100644
index 000000000000..e542f06048f3
--- /dev/null
+++ b/Documentation/virt/kvm/s390/s390-pv-dump.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+s390 (IBM Z) Protected Virtualization dumps
+===========================================
+
+Summary
+-------
+
+Dumping a VM is an essential tool for debugging problems inside
+it. This is especially true when a protected VM runs into trouble as
+there's no way to access its memory and registers from the outside
+while it's running.
+
+However when dumping a protected VM we need to maintain its
+confidentiality until the dump is in the hands of the VM owner who
+should be the only one capable of analysing it.
+
+The confidentiality of the VM dump is ensured by the Ultravisor who
+provides an interface to KVM over which encrypted CPU and memory data
+can be requested. The encryption is based on the Customer
+Communication Key which is the key that's used to encrypt VM data in a
+way that the customer is able to decrypt.
+
+
+Dump process
+------------
+
+A dump is done in 3 steps:
+
+**Initiation**
+
+This step initializes the dump process, generates cryptographic seeds
+and extracts dump keys with which the VM dump data will be encrypted.
+
+**Data gathering**
+
+Currently there are two types of data that can be gathered from a VM:
+the memory and the vcpu state.
+
+The vcpu state contains all the important registers, general, floating
+point, vector, control and tod/timers of a vcpu. The vcpu dump can
+contain incomplete data if a vcpu is dumped while an instruction is
+emulated with help of the hypervisor. This is indicated by a flag bit
+in the dump data. For the same reason it is very important to not only
+write out the encrypted vcpu state, but also the unencrypted state
+from the hypervisor.
+
+The memory state is further divided into the encrypted memory and its
+metadata comprised of the encryption tweaks and status flags. The
+encrypted memory can simply be read once it has been exported. The
+time of the export does not matter as no re-encryption is
+needed. Memory that has been swapped out and hence was exported can be
+read from the swap and written to the dump target without need for any
+special actions.
+
+The tweaks / status flags for the exported pages need to be requested
+from the Ultravisor.
+
+**Finalization**
+
+The finalization step will provide the data needed to be able to
+decrypt the vcpu and memory data and end the dump process. When this
+step completes successfully a new dump initiation can be started.
-- 
2.34.1


Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F1C5109D1
	for <lists+linux-s390@lfdr.de>; Tue, 26 Apr 2022 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354518AbiDZUMk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 Apr 2022 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354520AbiDZUM2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Apr 2022 16:12:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E716E844;
        Tue, 26 Apr 2022 13:09:15 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QK4HSJ010910;
        Tue, 26 Apr 2022 20:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SbYLO2GqlwwHbLUP+lhINJceTMUcJBWAqUSUVPmiqic=;
 b=RaxVoOI+IuhQYiI2KglNe0YifyCUo5j5f30iZk+04mepRrKwVCnKDhFd74Em9yZpIuyJ
 FtahcpF8m0d3FWKoFDBahuedQnKdcI0JaF7RG+9kTl7sbg5Fxu9PSyi83PAbhkZshRbq
 IB0Fh6wxFExmDKudGInwsbWjOYwjfLKmKoLcITUmMHTM0smXOBKeeY6iJA5eInNE0HZQ
 Rh2hD2uVsxVBMykFiTxH0VXv1HKLjgsa7jXgf/buf3GB8jQ/XuQpHl4gTo8DbapIqms/
 WiB3poCs2do1GlN6b+a8KsCtlUvjrHfSFgMqndpAZJKs0LCfbe3vAVMgZQ5GZkcNcSk3 qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj07ypwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 20:09:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QK7Fa0020282;
        Tue, 26 Apr 2022 20:09:13 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj07ypwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 20:09:12 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QK8aEV031491;
        Tue, 26 Apr 2022 20:09:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3fm939ffyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 20:09:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QK9A3025231660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 20:09:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C4AB2068;
        Tue, 26 Apr 2022 20:09:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EFAEB205F;
        Tue, 26 Apr 2022 20:09:06 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown [9.211.73.42])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 20:09:06 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        jgg@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 04/21] s390/sclp: detect the AISI facility
Date:   Tue, 26 Apr 2022 16:08:25 -0400
Message-Id: <20220426200842.98655-5-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220426200842.98655-1-mjrosato@linux.ibm.com>
References: <20220426200842.98655-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cgnzGa6VQr9YAkEulaN-Iziwsfseo1Nd
X-Proofpoint-ORIG-GUID: y6G6SFpMEJyNjyFbHtICBapURP7wMoaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_06,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=775 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Detect the Adapter Interruption Suppression Interpretation facility.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index ff359df62154..bdd365407176 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -90,6 +90,7 @@ struct sclp_info {
 	unsigned char has_zpci_lsi : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
+	unsigned char has_aisi : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index e9af01b4c97a..c13e55cc4a5d 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -47,6 +47,7 @@ static void __init sclp_early_facilities_detect(void)
 	sclp.has_kss = !!(sccb->fac98 & 0x01);
 	sclp.has_aisii = !!(sccb->fac118 & 0x40);
 	sclp.has_aeni = !!(sccb->fac118 & 0x20);
+	sclp.has_aisi = !!(sccb->fac118 & 0x10);
 	sclp.has_zpci_lsi = !!(sccb->fac118 & 0x01);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
-- 
2.27.0


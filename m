Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16BB114B3B
	for <lists+linux-s390@lfdr.de>; Fri,  6 Dec 2019 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfLFCuY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Dec 2019 21:50:24 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:46260 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFCuY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 21:50:24 -0500
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 21:50:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=a4CzE9P9Sv83fyUfeq
        1jc6MxRpP1ZXVGxEaARk3HmoY=; b=lyEBwfSl6RmafVlypvBzyXV3eoVhbBZ8e6
        4IbwOxU3MrioIBM5WeNVzVGl9Ce91qR936Pj/SA8UEQkr40JPQIorjPiKR84Apsl
        AFHsfHDf8qx9gbQrJf2To1aqBmKvGqzpAanPU5TtvzvP8MedyZ0S/v1rAYn3I1Em
        2kJkjpFuQ=
Received: from localhost.localdomain (unknown [218.106.182.184])
        by smtp3 (Coremail) with SMTP id G9xpCgD3+99EvuldgtBkAQ--.76S3;
        Fri, 06 Dec 2019 10:35:04 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Xidong Wang <wangxidong_97@163.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scsi: zfcp: check qdio before use
Date:   Fri,  6 Dec 2019 10:34:04 +0800
Message-Id: <1575599644-15837-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: G9xpCgD3+99EvuldgtBkAQ--.76S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry8Gry5CFWfXFW3Cw15Arb_yoW3WFgE9r
        97urn2qrWfCrs2krWUKw1UZryFkr4xurn3Crn3tayfZFnxJFZ7XF1vvFWDJw15Jw1jgwnr
        uw1qyFy09F17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbS4i5UUUUU==
X-Originating-IP: [218.106.182.184]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbi8BiD81uoV8DXCAAAsj
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In zfcp_fsf_fcp_cmnd(), zfcp_qdio_sbal_get(qdio) should
be checked before zfcp_fsf_req_create() is called.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index cf63916..8e460e3 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2292,6 +2292,9 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *scsi_cmnd)
 	if (scsi_cmnd->sc_data_direction == DMA_TO_DEVICE)
 		sbtype = SBAL_SFLAGS0_TYPE_WRITE;
 
+	if (zfcp_qdio_sbal_get(qdio))
+		goto out;
+
 	req = zfcp_fsf_req_create(qdio, FSF_QTCB_FCP_CMND,
 				  sbtype, adapter->pool.scsi_req);
 
-- 
2.7.4


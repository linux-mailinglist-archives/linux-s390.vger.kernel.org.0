Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC96B11B164
	for <lists+linux-s390@lfdr.de>; Wed, 11 Dec 2019 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfLKPag (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Dec 2019 10:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387889AbfLKP33 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B332467B;
        Wed, 11 Dec 2019 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078168;
        bh=vaIAzNlcw7syzXlDvK64mbKUZ0HDblQUzGJmKyy4I6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+xv825W3uqT1xTjGXrN9CePMNWf1XXEZ+1pKtT4OE3IXxEmfOYJ/KFkkHzcghLEp
         mGaVhtlQyBjjjpBrutrACeWDi5g51I0ZzcWeddRR5o0XxBk6GPKe+oW2H9+gOsDvkj
         mzlZFL+Md3proxctUrpnOxER5ZQ4ogKpi1kRXzTs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 53/58] s390/zcrypt: handle new reply code FILTERED_BY_HYPERVISOR
Date:   Wed, 11 Dec 2019 10:28:26 -0500
Message-Id: <20191211152831.23507-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 6733775a92eacd612ac88afa0fd922e4ffeb2bc7 ]

This patch introduces support for a new architectured reply
code 0x8B indicating that a hypervisor layer (if any) has
rejected an ap message.

Linux may run as a guest on top of a hypervisor like zVM
or KVM. So the crypto hardware seen by the ap bus may be
restricted by the hypervisor for example only a subset like
only clear key crypto requests may be supported. Other
requests will be filtered out - rejected by the hypervisor.
The new reply code 0x8B will appear in such cases and needs
to get recognized by the ap bus and zcrypt device driver zoo.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_error.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 9499cd3a05f85..02a936db00923 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -75,6 +75,7 @@ struct error_hdr {
 #define REP82_ERROR_EVEN_MOD_IN_OPND	    0x85
 #define REP82_ERROR_RESERVED_FIELD	    0x88
 #define REP82_ERROR_INVALID_DOMAIN_PENDING  0x8A
+#define REP82_ERROR_FILTERED_BY_HYPERVISOR  0x8B
 #define REP82_ERROR_TRANSPORT_FAIL	    0x90
 #define REP82_ERROR_PACKET_TRUNCATED	    0xA0
 #define REP82_ERROR_ZERO_BUFFER_LEN	    0xB0
@@ -105,6 +106,7 @@ static inline int convert_error(struct zcrypt_queue *zq,
 	case REP82_ERROR_INVALID_DOMAIN_PRECHECK:
 	case REP82_ERROR_INVALID_DOMAIN_PENDING:
 	case REP82_ERROR_INVALID_SPECIAL_CMD:
+	case REP82_ERROR_FILTERED_BY_HYPERVISOR:
 	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
 	//   REP88_ERROR_OPERAND		// '84' CEX2A
 	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
-- 
2.20.1


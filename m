Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E20FE3686
	for <lists+linux-s390@lfdr.de>; Thu, 24 Oct 2019 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbfJXPYi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 24 Oct 2019 11:24:38 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:35454 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfJXPYi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Oct 2019 11:24:38 -0400
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id HTQb210125USYZQ06TQc4S; Thu, 24 Oct 2019 17:24:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNeyZ-00076g-TW; Thu, 24 Oct 2019 17:24:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNeyZ-0007rH-SC; Thu, 24 Oct 2019 17:24:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] s390/dasd: spelling s/configruation/configuration/
Date:   Thu, 24 Oct 2019 17:24:33 +0200
Message-Id: <20191024152433.30165-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix misspelling of "configuration".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/s390/block/dasd_3990_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index ee73b0607e47c7c6..4691a3c35d725ec1 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1987,7 +1987,7 @@ dasd_3990_erp_compound_code(struct dasd_ccw_req * erp, char *sense)
  * DASD_3990_ERP_COMPOUND_CONFIG
  *
  * DESCRIPTION
- *   Handles the compound ERP action for configruation
+ *   Handles the compound ERP action for configuration
  *   dependent error.
  *   Note: duplex handling is not implemented (yet).
  *
-- 
2.17.1


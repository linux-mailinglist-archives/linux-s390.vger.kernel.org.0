Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0341E6F3AE
	for <lists+linux-s390@lfdr.de>; Sun, 21 Jul 2019 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGUOap (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 21 Jul 2019 10:30:45 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:38421 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUOap (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Jul 2019 10:30:45 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jul 2019 10:30:43 EDT
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-01.nifty.com with ESMTP id x6LEKlli000738
        for <linux-s390@vger.kernel.org>; Sun, 21 Jul 2019 23:20:48 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x6LEKI7X003650;
        Sun, 21 Jul 2019 23:20:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x6LEKI7X003650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563718819;
        bh=INW7SCnphIh64rKSIwbrY/qZ8SWy5OEFjQ4zyy+PpsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ewuXmkw9gCY1AIMc9CtzUh1bKWUq0Cl9q7iY6K8vkPjC9ZUOHUsou94wSbRfDIGu3
         7T8UubFc1ye5OHJ/UgoOWk1/MkpD5l8v3UMzZBRTMxH9pNkehBC5wEGmZp9SGUYGL7
         6En8ujq1fduPX2w1G9cMTVGRanmHrjLSGRddtkTgAROfmJbBW8rP1hXQy83IhQiHEh
         PuLGO28qVwyTRssQYNYxWqDNbuxp0OJEqd7VefuYUWGwNn02hhtd+TGxekKu0rH6P8
         fEVc50sJ0lETHt9onHljNbL0320jqxjI8wEbBY5RX9YFfdAB+rtABY22lPZUI22sX+
         MmhRHPNraXmLw==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: use __u{16,32,64} instead of uint{16,32,64}_t in uapi header
Date:   Sun, 21 Jul 2019 23:20:08 +0900
Message-Id: <20190721142008.30093-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
make sure they can be included from user-space.

Currently, zcrypt.h is excluded from the test coverage. To make it
join the compile-test, we need to fix the build errors attached below.

For a case like this, we decided to use __u{8,16,32,64} variable types
in this discussion:

  https://lkml.org/lkml/2019/6/5/18

Build log:

  CC      usr/include/asm/zcrypt.h.s
In file included from <command-line>:32:0:
./usr/include/asm/zcrypt.h:163:2: error: unknown type name ‘uint16_t’
  uint16_t cprb_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:168:2: error: unknown type name ‘uint32_t’
  uint32_t source_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:169:2: error: unknown type name ‘uint32_t’
  uint32_t target_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:170:2: error: unknown type name ‘uint32_t’
  uint32_t ret_code;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:171:2: error: unknown type name ‘uint32_t’
  uint32_t reserved1;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:172:2: error: unknown type name ‘uint32_t’
  uint32_t reserved2;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:173:2: error: unknown type name ‘uint32_t’
  uint32_t payload_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:182:2: error: unknown type name ‘uint16_t’
  uint16_t ap_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:183:2: error: unknown type name ‘uint16_t’
  uint16_t dom_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:198:2: error: unknown type name ‘uint16_t’
  uint16_t  targets_num;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:199:2: error: unknown type name ‘uint64_t’
  uint64_t  targets;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:200:2: error: unknown type name ‘uint64_t’
  uint64_t  weight;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:201:2: error: unknown type name ‘uint64_t’
  uint64_t  req_no;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:202:2: error: unknown type name ‘uint64_t’
  uint64_t  req_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:203:2: error: unknown type name ‘uint64_t’
  uint64_t  req;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:204:2: error: unknown type name ‘uint64_t’
  uint64_t  resp_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:205:2: error: unknown type name ‘uint64_t’
  uint64_t  resp;
  ^~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/uapi/asm/zcrypt.h | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/uapi/asm/zcrypt.h b/arch/s390/include/uapi/asm/zcrypt.h
index 494c34c50716..8c5755f41dde 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -20,6 +20,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /* Name of the zcrypt device driver. */
 #define ZCRYPT_NAME "zcrypt"
@@ -160,17 +161,17 @@ struct ica_xcRB {
  * @payload_len:	Payload length
  */
 struct ep11_cprb {
-	uint16_t	cprb_len;
+	__u16		cprb_len;
 	unsigned char	cprb_ver_id;
 	unsigned char	pad_000[2];
 	unsigned char	flags;
 	unsigned char	func_id[2];
-	uint32_t	source_id;
-	uint32_t	target_id;
-	uint32_t	ret_code;
-	uint32_t	reserved1;
-	uint32_t	reserved2;
-	uint32_t	payload_len;
+	__u32		source_id;
+	__u32		target_id;
+	__u32		ret_code;
+	__u32		reserved1;
+	__u32		reserved2;
+	__u32		payload_len;
 } __attribute__((packed));
 
 /**
@@ -179,8 +180,8 @@ struct ep11_cprb {
  * @dom_id:	Usage domain id
  */
 struct ep11_target_dev {
-	uint16_t ap_id;
-	uint16_t dom_id;
+	__u16 ap_id;
+	__u16 dom_id;
 };
 
 /**
@@ -195,14 +196,14 @@ struct ep11_target_dev {
  * @resp:		Addr to response block
  */
 struct ep11_urb {
-	uint16_t		targets_num;
-	uint64_t		targets;
-	uint64_t		weight;
-	uint64_t		req_no;
-	uint64_t		req_len;
-	uint64_t		req;
-	uint64_t		resp_len;
-	uint64_t		resp;
+	__u16		targets_num;
+	__u64		targets;
+	__u64		weight;
+	__u64		req_no;
+	__u64		req_len;
+	__u64		req;
+	__u64		resp_len;
+	__u64		resp;
 } __attribute__((packed));
 
 /**
-- 
2.17.1


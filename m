Return-Path: <linux-s390+bounces-342-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBC806898
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAB61F20FD3
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD011775A;
	Wed,  6 Dec 2023 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUvsjQdz"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5316429;
	Wed,  6 Dec 2023 07:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5433C433C7;
	Wed,  6 Dec 2023 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848257;
	bh=dQFCDmEpt5P6ThPydBMGELVuIhzHjl7/FVwjhyy0yRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUvsjQdzGwCfUKDjkBnh/6sqrgysLBucHf9QNxpTCbCY4llLHwlLyUSb2wcYenaUb
	 jG87KYRBZojYzewsCBheiyxTR4VpE8G0gBw/uY6yifqJq5i3AkCl3tbe4Noj0V0QIM
	 vqoXgTa/35sZnCChMUIhYLIRHWIrwbdl5uUR+MPnem7KSgL26UxJXAKIwOsFuchwnI
	 lboLuLBNTSCNJ/UPslvXHh2gX+97CnffjXIQ2IBaaNUwTDlWtbO16MH97vG1trDxcu
	 RPXaPiTEwD5YOckTLLLuCcqmG9uCgVJIOOatRfjCJJ5kncQnjMvAXkhr+5z3fX0ZPA
	 1oOsp61cFOkRg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 08/27] tty: con3215: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:36:53 +0100
Message-ID: <20231206073712.17776-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 34bc343dcfcc..0b0324fe4aff 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -79,8 +79,8 @@ struct raw3215_info {
 	struct ccw_device *cdev;      /* device for tty driver */
 	spinlock_t *lock;	      /* pointer to irq lock */
 	int flags;		      /* state flags */
-	char *buffer;		      /* pointer to output buffer */
-	char *inbuf;		      /* pointer to input buffer */
+	u8 *buffer;		      /* pointer to output buffer */
+	u8 *inbuf;		      /* pointer to input buffer */
 	int head;		      /* first free byte in output buffer */
 	int count;		      /* number of bytes in output buffer */
 	int written;		      /* number of bytes in write requests */
@@ -522,12 +522,14 @@ static unsigned int raw3215_make_room(struct raw3215_info *raw,
  *	string	without blocking.
  *	Return value is the number of bytes copied.
  */
-static unsigned int raw3215_addtext(const char *str, unsigned int length,
+static unsigned int raw3215_addtext(const u8 *str, size_t length,
 				    struct raw3215_info *raw, int opmode,
 				    unsigned int todrop)
 {
-	unsigned int c, ch, i, blanks, expanded_size = 0;
+	unsigned int i, blanks, expanded_size = 0;
 	unsigned int column = raw->line_pos;
+	size_t c;
+	u8 ch;
 
 	if (opmode == RAW3215_COUNT)
 		todrop = 0;
@@ -558,7 +560,7 @@ static unsigned int raw3215_addtext(const char *str, unsigned int length,
 		if (todrop && expanded_size < todrop)	/* Drop head data */
 			continue;
 		for (i = 0; i < blanks; i++) {
-			raw->buffer[raw->head] = (char)_ascebc[(int)ch];
+			raw->buffer[raw->head] = _ascebc[ch];
 			raw->head = (raw->head + 1) & (RAW3215_BUFFER_SIZE - 1);
 			raw->count++;
 		}
@@ -570,8 +572,8 @@ static unsigned int raw3215_addtext(const char *str, unsigned int length,
 /*
  * String write routine for 3215 devices
  */
-static void raw3215_write(struct raw3215_info *raw, const char *str,
-			  unsigned int length)
+static void raw3215_write(struct raw3215_info *raw, const u8 *str,
+			  size_t length)
 {
 	unsigned int count, avail;
 	unsigned long flags;
@@ -596,7 +598,7 @@ static void raw3215_write(struct raw3215_info *raw, const char *str,
 /*
  * Put character routine for 3215 devices
  */
-static void raw3215_putchar(struct raw3215_info *raw, unsigned char ch)
+static void raw3215_putchar(struct raw3215_info *raw, u8 ch)
 {
 	raw3215_write(raw, &ch, 1);
 }
@@ -823,12 +825,10 @@ static struct ccw_driver raw3215_ccw_driver = {
 	.int_class	= IRQIO_C15,
 };
 
-static void handle_write(struct raw3215_info *raw, const char *str, int count)
+static void handle_write(struct raw3215_info *raw, const u8 *str, size_t count)
 {
-	int i;
-
 	while (count > 0) {
-		i = min_t(int, count, RAW3215_BUFFER_SIZE - 1);
+		size_t i = min_t(size_t, count, RAW3215_BUFFER_SIZE - 1);
 		raw3215_write(raw, str, i);
 		count -= i;
 		str += i;
-- 
2.43.0



Return-Path: <linux-s390+bounces-3925-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C78C0468
	for <lists+linux-s390@lfdr.de>; Wed,  8 May 2024 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C49D287F4E
	for <lists+linux-s390@lfdr.de>; Wed,  8 May 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92386130E4F;
	Wed,  8 May 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is+lmrBe"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB07130A5D
	for <linux-s390@vger.kernel.org>; Wed,  8 May 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193027; cv=none; b=ptzSuD92gfe3LoS/4opi8TAeVoxZXe6vH7iQDS9fS07khltwcjd7bvvzw8V9fOOvL8omADKHw2txJUKoi41Vlw0LHvH1Ryz1VX8bBC5d3de4wlm+7quEnnv1RG3gAhw2K6Bvx+BpJicLl+zf33tEU8PvHHfg+0nG2iXjpnAIpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193027; c=relaxed/simple;
	bh=2jYn8Nc6+ozSR1Xn/B9+Ij4CHbheK6aJy1ZEPlp0hzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkNq4QKTPHGpcViFCpLnd7IYgQ/R9WPaSST77sfw0hggtLtxxG+KjC0V1t4hKDshPkeitqAtOfsGLDPv/BkouXWiB4SYuHfKKGFMVTjnNR7bFPW5gDQIQdXyLKSiCWujbBelsbst4GjdA9cASV4Lm2Eql/B5H3zayorcomvOAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=is+lmrBe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4sBosY++fTH5Chz3WH+OVztpSiojrQgo/6j44g/xQVs=;
	b=is+lmrBeDIC3L758DTe/J2Y268e7Ecx2OMSeueLI4ijmHkP0QZ66rOrPjlhneSR1i0t+25
	JPkYltgKgi5ZnJk4SZSYkEAiNXKAwCgYsrvKKBSi7BE1rF4BKEiBK4c2tw0GM6hQR97Ko8
	BAZ1jwmk7qQHY8d6bnBcHpZuciJB5fs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-EmvBefZoPPCR3lind5eOTg-1; Wed, 08 May 2024 14:30:20 -0400
X-MC-Unique: EmvBefZoPPCR3lind5eOTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04CC98016FA;
	Wed,  8 May 2024 18:30:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3CFB10009E6;
	Wed,  8 May 2024 18:30:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 06/10] s390/uv: make uv_convert_from_secure() a static function
Date: Wed,  8 May 2024 20:29:51 +0200
Message-ID: <20240508182955.358628-7-david@redhat.com>
In-Reply-To: <20240508182955.358628-1-david@redhat.com>
References: <20240508182955.358628-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

It's not used outside of uv.c, so let's make it a static function.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/uv.h | 6 ------
 arch/s390/kernel/uv.c      | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 0e7bd3873907..d2205ff97007 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -484,7 +484,6 @@ int uv_pin_shared(unsigned long paddr);
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr);
 int uv_destroy_owned_page(unsigned long paddr);
-int uv_convert_from_secure(unsigned long paddr);
 int uv_convert_owned_from_secure(unsigned long paddr);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
@@ -503,11 +502,6 @@ static inline int uv_destroy_owned_page(unsigned long paddr)
 	return 0;
 }
 
-static inline int uv_convert_from_secure(unsigned long paddr)
-{
-	return 0;
-}
-
 static inline int uv_convert_owned_from_secure(unsigned long paddr)
 {
 	return 0;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index ecfc08902215..3d3250b406a6 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -156,7 +156,7 @@ int uv_destroy_owned_page(unsigned long paddr)
  *
  * @paddr: Absolute host address of page to be exported
  */
-int uv_convert_from_secure(unsigned long paddr)
+static int uv_convert_from_secure(unsigned long paddr)
 {
 	struct uv_cb_cfs uvcb = {
 		.header.cmd = UVC_CMD_CONV_FROM_SEC_STOR,
-- 
2.45.0



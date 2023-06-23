Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E773B3CE
	for <lists+linux-s390@lfdr.de>; Fri, 23 Jun 2023 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFWJkg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 23 Jun 2023 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFWJkf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 05:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BD4B7
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687513190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gRyPsYNMsmn7yEoiSn1NbaSs0ga5/o0J6ddDdrg5+Vc=;
        b=hqm6WJPeASRIOWTuDNYWQJMbcPHWIKef8XgFTHPVgYzMyRukiPPYPvf9gwqmjHb8wq+xVb
        lNBjZG9xfb+WIbjaLcbwFi+Qn7x+HkESt370GumcRCfqwdvCQy5upQeORIiuF5H2hns0ww
        LAOMDxsB1IF5aeEnHGeYoyO+PxNH7Dc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-F37DcmT1Md-rmuefAejvuA-1; Fri, 23 Jun 2023 05:39:46 -0400
X-MC-Unique: F37DcmT1Md-rmuefAejvuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D671380451B;
        Fri, 23 Jun 2023 09:39:45 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 291F3492B01;
        Fri, 23 Jun 2023 09:39:43 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH] s390x: Align __bss_end to a halfword boundary
Date:   Fri, 23 Jun 2023 11:39:41 +0200
Message-Id: <20230623093941.448147-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We are using the "larl" instruction to load the address of __bss_end,
and this instruction can only deal with even addresses, so we have
to make sure that this symbol is aligned accordingly. Otherwise this
will cause a failure with the new binutils 2.40 and Clang:

 /usr/bin/ld: s390x/cstart64.o(.init+0x6a): misaligned symbol `__bss_end'
              (0x2c0d1) for relocation R_390_PC32DBL

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x/flat.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/s390x/flat.lds.S b/s390x/flat.lds.S
index 0cb7e383..5e91ecac 100644
--- a/s390x/flat.lds.S
+++ b/s390x/flat.lds.S
@@ -37,6 +37,7 @@ SECTIONS
 	. = ALIGN(16);
 	__bss_start = .;
 	.bss : { *(.bss) }
+	. = ALIGN(2);
 	__bss_end = .;
 	. = ALIGN(4K);
 	edata = .;
-- 
2.39.3


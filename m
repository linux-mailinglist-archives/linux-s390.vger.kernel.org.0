Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4F1C0013
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2020 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgD3PYp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Apr 2020 11:24:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbgD3PYp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588260284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlSoJiivlfHDjecLcSWOaOhzGMAzFZnEl4plhwLg4rk=;
        b=O6cTl7Qb+LgLRNcbBkpFdAkUhsIFGkCVAn7COYXhTHqRvNXIbXlo0CxKyOb33XZ3GXZQNU
        UIRY4zawvC3TLSkZxHPWefNu9Ps1vjPGeYYN4waGCrCZuycM5QhXIkB8hhy+RNzDLai2/h
        6qW22TIfQn4czwlmpRHbxzei1rSP1Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-P7XBeYErMEmKjkj8VX1jLA-1; Thu, 30 Apr 2020 11:24:42 -0400
X-MC-Unique: P7XBeYErMEmKjkj8VX1jLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 568668005B7;
        Thu, 30 Apr 2020 15:24:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C55015EDE3;
        Thu, 30 Apr 2020 15:24:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 03/17] MAINTAINERS: s390x: add linux-s390 list
Date:   Thu, 30 Apr 2020 17:24:16 +0200
Message-Id: <20200430152430.40349-4-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Cornelia Huck <cohuck@redhat.com>

It makes sense to cc: patches there as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200324121722.9776-3-cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4642909..52a3eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -83,6 +83,7 @@ M: David Hildenbrand <david@redhat.com>
 M: Janosch Frank <frankja@linux.ibm.com>
 R: Cornelia Huck <cohuck@redhat.com>
 L: kvm@vger.kernel.org
+L: linux-s390@vger.kernel.org
 F: s390x/*
 F: lib/s390x/*
=20
--=20
2.25.3


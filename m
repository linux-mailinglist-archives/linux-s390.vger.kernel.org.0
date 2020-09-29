Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2599D27C2C9
	for <lists+linux-s390@lfdr.de>; Tue, 29 Sep 2020 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgI2Kvb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Sep 2020 06:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbgI2Kvb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Sep 2020 06:51:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601376690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlolDIQkPxWdCEhvMrCOPr0WrRdtWzVOCtABr8L5Kk0=;
        b=Kz+mKOeyW0/dbnrllXbF1u5USLsp9knjnMX3j3mFgn6ZubgehAxVCD4bGLtRJzhfgXDMJe
        c8fGYTBV8o/9ARXoGKUB9ilgl/S4sW9bJVy3y3jnZllPHlOKZIv4Xz/BBLGNw7BPk+8G11
        n3KUmTp5o9LiKQdHEgquUJbho8Qmxbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-lYfzekrYPFuBGzGBMyf3HQ-1; Tue, 29 Sep 2020 06:51:26 -0400
X-MC-Unique: lYfzekrYPFuBGzGBMyf3HQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1858015C3;
        Tue, 29 Sep 2020 10:51:25 +0000 (UTC)
Received: from gondolin (ovpn-113-63.ams2.redhat.com [10.36.113.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C93167880B;
        Tue, 29 Sep 2020 10:51:20 +0000 (UTC)
Date:   Tue, 29 Sep 2020 12:51:18 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH v2 2/4] s390x: pv: implement routine to
 share/unshare memory
Message-ID: <20200929125118.26566182.cohuck@redhat.com>
In-Reply-To: <1601303017-8176-3-git-send-email-pmorel@linux.ibm.com>
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
        <1601303017-8176-3-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 28 Sep 2020 16:23:35 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When communicating with the host we need to share part of
> the memory.
> 
> Let's implement the ultravisor calls for this.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>


Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753581E3DD1
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2020 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgE0Jp2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 27 May 2020 05:45:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgE0Jp1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 05:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590572726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv8e/8IYWiFZa52nWbfRlHdWMY27KdY53fakPZ6y8BY=;
        b=fOF9dvceNOsuMYJ4/9jdygeqPXZe0ibNdEIO2m59hPM6wZo7l4G6YYRE6eT/+jdjmhbD5E
        WH6U7620fNCLw/DBZ9KQvzNT5mYyI8R/8vsAXegRoBrxRz65XZOm7hzI3qTnP3kuuY9lyB
        ok6naIX36Gqq9WcGN82gjTjzx9LPX/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Rfh2PV39OXiEwyNUnRMSZw-1; Wed, 27 May 2020 05:45:21 -0400
X-MC-Unique: Rfh2PV39OXiEwyNUnRMSZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C271D100960F;
        Wed, 27 May 2020 09:45:20 +0000 (UTC)
Received: from gondolin (ovpn-112-223.ams2.redhat.com [10.36.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3F1D1CA;
        Wed, 27 May 2020 09:45:16 +0000 (UTC)
Date:   Wed, 27 May 2020 11:45:14 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v7 10/12] s390x: define function to wait
 for interrupt
Message-ID: <20200527114514.0987a3a0.cohuck@redhat.com>
In-Reply-To: <1589818051-20549-11-git-send-email-pmorel@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
        <1589818051-20549-11-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 18 May 2020 18:07:29 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Allow the program to wait for an interrupt.
> 
> The interrupt handler is in charge to remove the WAIT bit
> when it finished handling the interrupt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


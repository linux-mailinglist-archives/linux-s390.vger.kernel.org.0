Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF222C825A
	for <lists+linux-s390@lfdr.de>; Mon, 30 Nov 2020 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgK3KkG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Nov 2020 05:40:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728229AbgK3KkF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606732719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFMcrWC8S89zTtE1jsxE6g4ajbJKLj1zQ53ePv4k9tQ=;
        b=RjhIVr1QSPvHVIrY2HhBhnLd/swI+lf/BpDeIqCBqbPZEBsAF5PiVZLVYlM0gAMW80Spjt
        j1WA+wVfSKpfk0uPDYCoH/XdnJj6Wdd0tZJ2k78B6YtUmvyDW6dgAiwrlhOqG0anH3i0Gc
        FcsuNjUZcgTpVdY6MonEvNUfBFGhjVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-UxECRvcFPpOLuHs1mUvcTw-1; Mon, 30 Nov 2020 05:38:37 -0500
X-MC-Unique: UxECRvcFPpOLuHs1mUvcTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B45B100E420;
        Mon, 30 Nov 2020 10:38:36 +0000 (UTC)
Received: from gondolin (ovpn-113-87.ams2.redhat.com [10.36.113.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 762B05D6A8;
        Mon, 30 Nov 2020 10:38:31 +0000 (UTC)
Date:   Mon, 30 Nov 2020 11:38:28 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com,
        borntraeger@de.ibm.com, imbrenda@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 3/7] s390x: SCLP feature checking
Message-ID: <20201130113828.593b94f7.cohuck@redhat.com>
In-Reply-To: <20201127130629.120469-4-frankja@linux.ibm.com>
References: <20201127130629.120469-1-frankja@linux.ibm.com>
        <20201127130629.120469-4-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 27 Nov 2020 08:06:25 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Availability of SIE is announced via a feature bit in a SCLP info CPU
> entry. Let's add a framework that allows us to easily check for such
> facilities.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 19 +++++++++++++++++++
>  lib/s390x/sclp.h | 13 ++++++++++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


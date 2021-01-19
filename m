Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3C2FBDAD
	for <lists+linux-s390@lfdr.de>; Tue, 19 Jan 2021 18:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbhASRaj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Jan 2021 12:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730175AbhASQaM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 11:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMKka954D9qrNNI9iQjMLHCWsX9H2W8HdjhdWuC87to=;
        b=jVl98jriO1eweSq7OsDTGpY4EjjejWBNeOGZ09sOy7xvMVi5qGIqp8bt4s3712RmuioduD
        uoUvcUxHce/nE8K4yDVw8DSPIWjmejkuPRkNHCU0qcg5xwwcFlVqPLYWT0LvUZ4+MXethI
        b4iIXGmBt3lWuHtvkC2tF1hgQowJrZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-9Amoyvo2PpO6yhM4MyxaCQ-1; Tue, 19 Jan 2021 11:28:38 -0500
X-MC-Unique: 9Amoyvo2PpO6yhM4MyxaCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F478066E6;
        Tue, 19 Jan 2021 16:28:36 +0000 (UTC)
Received: from gondolin (ovpn-113-246.ams2.redhat.com [10.36.113.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A274866A16;
        Tue, 19 Jan 2021 16:28:32 +0000 (UTC)
Date:   Tue, 19 Jan 2021 17:28:30 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Fix uv_call() exception
 behavior
Message-ID: <20210119172754.6eefa4da.cohuck@redhat.com>
In-Reply-To: <20210118150922.5229-1-frankja@linux.ibm.com>
References: <20210118140344.3074-1-frankja@linux.ibm.com>
        <20210118150922.5229-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 18 Jan 2021 10:09:22 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> On a program exception we usually skip the instruction that caused the
> exception and continue. That won't work for UV calls since a "brc
> 3,0b" will retry the instruction if the CC is > 1. Let's forgo the brc
> when checking for privilege exceptions and use a uv_call_once().
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> ---
>  lib/s390x/asm/uv.h | 24 ++++++++++++++++--------
>  s390x/uv-guest.c   |  6 +++---
>  2 files changed, 19 insertions(+), 11 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


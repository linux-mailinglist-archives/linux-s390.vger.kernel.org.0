Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE613B0FA
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jan 2020 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgANRcT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Jan 2020 12:32:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726669AbgANRcT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jan 2020 12:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579023138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Yz90B8GmMIWzrKxrkLuFNq92zftfc/1no2n+xOhrRY=;
        b=ViDTx+bq54cPxtWXOrejSiJicZvPFy5WG8fTpaLVhIbNU6KtmyNAEbbq5WqVgoDPTrd7Ps
        uTo5RZviaRrIS7HRMmNSfJByz1NTOR9dOEUlC5jKXJd/L7DHRrvPpapTlMm+tEj1IHe8rt
        Yzlf08ydUj7HM8czQSzHzh9dnwGYRgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-B-6O4LwFNdSVUg9mh6oRIA-1; Tue, 14 Jan 2020 12:32:17 -0500
X-MC-Unique: B-6O4LwFNdSVUg9mh6oRIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6231800D41;
        Tue, 14 Jan 2020 17:32:15 +0000 (UTC)
Received: from gondolin (ovpn-117-161.ams2.redhat.com [10.36.117.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F4CF5C1D6;
        Tue, 14 Jan 2020 17:32:14 +0000 (UTC)
Date:   Tue, 14 Jan 2020 18:32:11 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com
Subject: Re: [kvm-unit-tests PATCH 1/4] s390x: smp: Cleanup smp.c
Message-ID: <20200114183211.617ecb7e.cohuck@redhat.com>
In-Reply-To: <20200114153054.77082-2-frankja@linux.ibm.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
        <20200114153054.77082-2-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Jan 2020 10:30:50 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's remove a lot of badly formatted code by introducing the
> wait_for_flag() function.
> 
> Also let's remove some stray spaces.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)

This looks like some nice copy/paste had been going on :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


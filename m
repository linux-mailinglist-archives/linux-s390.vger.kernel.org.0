Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4921504E4
	for <lists+linux-s390@lfdr.de>; Mon,  3 Feb 2020 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBCLHL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Feb 2020 06:07:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727885AbgBCLHL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Feb 2020 06:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580728030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XbbnojOswnxklXUij++lE0KyUexKX21cqycaqs9nLg=;
        b=GTcNGdR2MkIvu9UkEIf0bkLSh0AvprC09gbn7abdzWS8TZS/20RW7TdThG3LVM2VQXDI8V
        E6arZBZ2fh+o3DjQmfozW3a6qAzzyWKQbgfVkEASo2mhywZp/GFNA6wI2FCvsGwSXdWkx8
        PKOh0z7pP+jcoRH90BO9lNmO/BIoc0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-oDJw2JGhP3qGAFmzUY2tVQ-1; Mon, 03 Feb 2020 06:07:07 -0500
X-MC-Unique: oDJw2JGhP3qGAFmzUY2tVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB83800D41;
        Mon,  3 Feb 2020 11:07:06 +0000 (UTC)
Received: from gondolin (ovpn-117-79.ams2.redhat.com [10.36.117.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD621E2C0;
        Mon,  3 Feb 2020 11:07:02 +0000 (UTC)
Date:   Mon, 3 Feb 2020 12:06:59 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com
Subject: Re: [kvm-unit-tests PATCH v5 2/7] s390x: smp: Fix ecall and emcall
 report strings
Message-ID: <20200203120659.5bac2010.cohuck@redhat.com>
In-Reply-To: <20200201152851.82867-3-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
        <20200201152851.82867-3-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat,  1 Feb 2020 10:28:46 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Instead of "smp: ecall: ecall" we now get "smp: ecall: received".
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


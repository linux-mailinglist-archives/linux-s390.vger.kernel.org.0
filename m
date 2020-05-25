Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8261E0AEE
	for <lists+linux-s390@lfdr.de>; Mon, 25 May 2020 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbgEYJo2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 25 May 2020 05:44:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389517AbgEYJo1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 05:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590399866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGicF2S4PcK/VsPvbgcOMfL+iuycdomjUBsa8XijigA=;
        b=CuhLy3ipiUc+v7oIpgQoXTHO2XZn2mfa5ImBnh0c9xqbhFb89+GiwdrSAbqwKGCpi0XRTU
        jeILRJd2BsYYRPy19XHj8FrbSDsPJaamFvJIGbmHMD25N+0kvgBddbdhRiQnCzbO0TeCdm
        nc4jUF/1Pwig0cj8VIG6xVnwNbrQKhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Dm72cZ8wPuuTbIupswzjOg-1; Mon, 25 May 2020 05:44:25 -0400
X-MC-Unique: Dm72cZ8wPuuTbIupswzjOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2195460;
        Mon, 25 May 2020 09:44:23 +0000 (UTC)
Received: from gondolin (ovpn-112-215.ams2.redhat.com [10.36.112.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A45095D9C5;
        Mon, 25 May 2020 09:44:19 +0000 (UTC)
Date:   Mon, 25 May 2020 11:43:35 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com,
        stzi@linux.ibm.com, mhartmay@linux.ibm.com, david@redhat.com
Subject: Re: [kvm-unit-tests PATCH] s390x: stsi: Make output tap13
 compatible
Message-ID: <20200525114335.49bd0b7a.cohuck@redhat.com>
In-Reply-To: <20200525084340.1454-1-frankja@linux.ibm.com>
References: <20200525084340.1454-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 25 May 2020 10:43:40 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> In tap13 output # is a special character and only "skip" and "todo"
> are allowed to come after it. Let's appease our CI environment and
> replace # with "count".
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/stsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

